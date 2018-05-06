module Harmonizer
  include CategoryMatcher
  include OdmLicenses
  include HashSearch
  # Haben diese Sachen bei den APIS die gleiche Bedeutung? Dieses "Matching auf den richtigen Tag nur bei Kategorien machen"
  ADDITIONAL_COMPLETENESS_VALUES = ['author','maintainer_email','author_email']
  NEEDED_DATASET_VALUES = ['id', 'title','url', {'category': ['tags', 'groups']}, 'maintainer', {'license': ['license', 'license_title', 'license_url']}, 'metadata_created', 'metadata_modified'].freeze
  NEEDED_DATARESOURCE_VALUES = ['id', 'url', {'data_format': ['format']}, {'metadata_created': ['created', 'metadata_created']}, 'metadata_modified']
  # man bekommt zunächst einmal das Array mit den ganzen Objekten. Also der Response. lässt sich nicht eindeutig identifizieren. Merkmal: response und darunter Array.
  # man hat die ganzen Datensätze und möchte dann die Attribute aus dem Datensatz übernehmen, die ich übernehmen kann.
  # nach welchen Attributen suche ich?
  # Da es für jeden Wert mehrere Werte gibt, müsste man jeden Datensatz zumindestens beim ersten mal mit ziemlichen Aufwand analysieren. Für jedes Attribut, theoretisch mehrere Mögl. möglich
  def harmonize_dataset(dataset_id, dataset, city_id)
    puts "--------dataset---------"
    dataset.except!('resources') if handle_resources(dataset_id, dataset.fetch('resources', nil))
    @results = Hash.new
    @results["missing_keys"] = Array.new
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
    @results.delete('hello')
    @results[:license] = get_license(@results[:license])
    @results[:category] = get_groups_of_dataset(@results[:category])
    @results.each {|key, value| @results['missing_keys'] << key.to_s if !value.nil? && value.blank? && key != 'missing_keys'}
    ADDITIONAL_COMPLETENESS_VALUES.each do |f|
      @results['missing_keys'] << f if (!dataset.fetch(f, nil)).blank?
    end
    puts @results
    puts "success" if Dataset.find(dataset_id).update(@results)
  end

  def handle_resources(dataset_id, resources)
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
          # Reports the missing key in the dataset.
          # It seems to be useful, to seperately save and handle the resources.
        rescue NoMethodError=> e
          puts e
        end
      end
      @harmonized_resource["data_format"] = get_format(@harmonized_resource[:data_format], @harmonized_resource['url'])
      @harmonized_resource[:metadata_created] = get_metadata_created(@harmonized_resource[:metadata_created])
      @harmonized_resource['dataset_id'] = dataset_id
      if DataResource.find_by(unique_identifier: @harmonized_resource["unique_identifier"])
        DataResource.find_by(unique_identifier: @harmonized_resource["unique_identifier"]).update(@harmonized_resource)
      else
        DataResource.create(@harmonized_resource)
      end
    end
  end

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
