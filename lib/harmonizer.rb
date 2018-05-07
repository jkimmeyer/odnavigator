module Harmonizer
  include CategoryMatcher
  include OdmLicenses
  include HashSearch

  # Für die Harmonisierung benötigte Konstanten.
  ADDITIONAL_COMPLETENESS_VALUES = ['author','maintainer_email','author_email'].freeze
  NEEDED_DATASET_VALUES = ['id', 'title','url', {'category': ['tags', 'groups']}, 'maintainer', {'license': ['license', 'license_title', 'license_url']}, 'metadata_created', 'metadata_modified'].freeze
  NEEDED_DATARESOURCE_VALUES = ['id', 'url', {'data_format': ['format']}, {'metadata_created': ['created', 'metadata_created']}, 'metadata_modified']

  # Harmonisiert einen Datensatz
  def harmonize_dataset(dataset_id, dataset, city_id)
    # Entfernen der Ressourcen aus dem Hash und seperate Behandlung --> Wird noch in Jobs ausgelagert später
    dataset.except!('resources') if handle_resources(dataset_id, dataset.fetch('resources', nil))
    # In diesem Hash befindet sich nacher der fertige Datensatz
    @results = Hash.new
    @results["missing_keys"] = Array.new

    # Durchsucht einen Datensatz nach allen Werten, wenn einer nicht gefunden wird,
    # dann wird der Wert ins Missing Keys Array aufgenommen.
    NEEDED_DATASET_VALUES.each do |f|
      begin
        if f.is_a? Hash
          @results[f.keys.first] = Hash.new
          f.values.flatten.each do |s|
            next unless dataset.fetch(s, nil)
            @results[f.keys.first].merge!(s => dataset.fetch(s, nil))
          end
          @results['missing_keys'] << f unless @results[f.keys.first]
        else
          @results['unique_identifier'] = dataset.fetch(f) if (f == 'id')
          @results[f] = dataset.fetch(f) if (f != 'id')
        end
      rescue KeyError
        # Reports the missing key in the dataset.
        @results['missing_keys'] << f
      rescue => e
        puts e
      end
    end

    # Lizenz und Kategorie müssen erst genau identifiziert werden, weil es keine einheitlichen Metadaten für diese Felder gibt.
    @results[:license] = get_license(@results[:license])
    @results[:category] = get_groups_of_dataset(@results[:category])

    # Fügt auch noch Werte die einen leeren String o.ä. besitzen zu den fehlenden Keys dazu.
    @results.each {|key, value| @results['missing_keys'] << key.to_s if !value.nil? && value.blank? && key != 'missing_keys'}

    ADDITIONAL_COMPLETENESS_VALUES.each do |f|
      @results['missing_keys'] << f if (!dataset.fetch(f, nil)).blank?
    end

    puts "success" if Dataset.find(dataset_id).update(@results)
  end

  def handle_resources(dataset_id, resources)
    # Jede Ressource wird einzeln überprüft, das Prinzip funktioniert wie oben.
    resources&.each do |resource|
      @harmonized_resource = Hash.new
      NEEDED_DATARESOURCE_VALUES.each do |f|
        begin
          if f.is_a? Hash
            @harmonized_resource[f.keys.first] = Hash.new
            f.values.flatten.each do |s|
              next unless resource.fetch(s, nil)
              @harmonized_resource[f.keys.first].merge!(s => resource.fetch(s, nil))
            end
          else
            @harmonized_resource['unique_identifier'] = resource.fetch(f, nil) if (f == 'id')
            @harmonized_resource[f] = resource.fetch(f, nil) if (f != 'id')
          end
        rescue KeyError => e
          puts e
        rescue NoMethodError=> e
          puts e
        end
      end

      # Diese Werte müssen genauer identifiziert werden.
      @harmonized_resource["data_format"] = get_format(@harmonized_resource[:data_format], @harmonized_resource['url'])
      @harmonized_resource[:metadata_created] = get_metadata_created(@harmonized_resource[:metadata_created])
      @harmonized_resource['dataset_id'] = dataset_id

      # Datenressourcen können bei der Abfrage auch noch nicht bestehen, daher müssen diese entweder geupdated oder erstellt werden.
      if DataResource.find_by(unique_identifier: @harmonized_resource["unique_identifier"])
        DataResource.find_by(unique_identifier: @harmonized_resource["unique_identifier"]).update(@harmonized_resource)
      else
        DataResource.create(@harmonized_resource)
      end
    end
  end

# Helfermethoden.
  def get_metadata_created(metadata_created)
    return metadata_created['created'] || metadata_created['metadata_created']
  end

  def get_license(license)
    return license['license'] || license['license_title'] || license['license_url']
  end

  def get_format(data_format, url)
    return data_format["format"] || (url.match(/\.\w{3,4}($|\?)/).to_s).gsub(/\./, '')
  end
end
