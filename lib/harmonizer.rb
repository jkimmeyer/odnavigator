module Harmonizer
  # Haben diese Sachen bei den APIS die gleiche Bedeutung? Dieses "Matching auf den richtigen Tag nur bei Kategorien machen"
  NEEDED_DATASET_VALUES = ['id', 'title', 'url', 'maintainer', {'category': ['tags', 'groups']}, 'license_title'].freeze
  NEEDED_DATARESOURCE_VALUES = ['id', 'url', 'format', 'created', 'license']
  # man bekommt zunächst einmal das Array mit den ganzen Objekten. Also der Response. lässt sich nicht eindeutig identifizieren. Merkmal: response und darunter Array.
  # man hat die ganzen Datensätze und möchte dann die Attribute aus dem Datensatz übernehmen, die ich übernehmen kann.
  # nach welchen Attributen suche ich?
  # Da es für jeden Wert mehrere Werte gibt, müsste man jeden Datensatz zumindestens beim ersten mal mit ziemlichen Aufwand analysieren. Für jedes Attribut, theoretisch mehrere Mögl. möglich
  def harmonize_dataset(dataset, city_id)
    puts "--------dataset---------"
    dataset.except!('resources') if handle_resources(dataset.fetch('resources', nil))
    @results = Hash.new
    @results["missing_keys"] = Array.new
    NEEDED_DATASET_VALUES.each do |f|
      begin
        if f.is_a? Hash
          @results[f.keys.first] = Array.new
          f.values.flatten.each do |s|
            next if dataset.fetch(s, nil)
            @results[f.keys.first] += [{s => dataset.fetch(s, nil)}]
          end
          @results["missing_keys"] << f unless @results[f.keys.first]
        else
          @results[f] = dataset.fetch(f)
        end
      rescue KeyError
        # Reports the missing key in the dataset.
        # It seems to be useful, to seperately save and handle the resources.
        @results["missing_keys"] << f
      rescue => e
        puts e
      end
    end
    @results["city_id"] = city_id
    return @results
  end

  def handle_resources(resources)
    @results = Hash.new
    resources.each do |resource|
      NEEDED_DATARESOURCE_VALUES.each do |f|
        begin
          next if resource.fetch(f, nil)
          @results[f] = resource.fetch(f, nil)
        rescue KeyError => e
          puts e
          # Reports the missing key in the dataset.
          # It seems to be useful, to seperately save and handle the resources.
        rescue NoMethodError=> e
          skip!
          puts e
        end
      end
    end
  @resource = DataResource.new(@results)
  @resource["dataset_id"] = self.data_portal_id
  @resource.save
  end
end
