class FetchDatasetsService
  def self.call()
    new.call()
  end

  def call()

    CityPortal.all.each do |city_portal|
      city_portal.reindex_datasets
    end

    Dataset.all.each do |dataset|
      dataset.request_metadata
    end

    CityPortal.all.each do |city_portal|
      MetricCalculatorService.call(city_portal)
    end

  end
end
