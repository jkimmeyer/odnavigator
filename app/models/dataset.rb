class Dataset < ApplicationRecord
  include OdmLicenses
  include Harvester
  # remove this down here
  include Harmonizer

  belongs_to :city_portal
  has_many :data_resources

  def request_metadata
    # In Case if Job Queue should not handle this.
     @dataset = get_dataset_details(self.city_portal.data_portal.url, self.package_search_title)
    #FetchDatasetsJob.perform_later(self.id, @dataset, self.city_portal.city_id)
    if !@dataset.is_a? Integer
      harmonize_dataset(self.id, @dataset, self.city_portal.city_id)
      self.update(active: true)
    else
      self.update(active: false)
    end
  end

  def openness
    return get_open_licenses.include?(self.license&.downcase)
  end

  def machine_readable
    machine_readable = false
    self.data_resources.each do |f|
      machine_readable = f.machine_readable if f.machine_readable
    end
    return machine_readable
  end

  def non_proprietary
    non_proprietary = false
    self.data_resources.each do |f|
      non_proprietary = f.non_proprietary if f.non_proprietary
    end
    return non_proprietary
  end

  def calc_completeness
    return (100.00 - (self.missing_keys.count.to_f / 11.00 * 100.00)).round(2)
  end
end
