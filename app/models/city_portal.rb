class CityPortal < ApplicationRecord

  # include HashSearch
  # include CategoryMatcher
  # include Harmonizer
  include Harvester

  belongs_to :city
  belongs_to :data_portal
  has_many :datasets

  CACHE_POLICY = lambda { 3.day.ago }
  validates :city, uniqueness: {scope: :data_portal}
  after_create :initial_setup


  # just create if no entry can be found
  def reindex_datasets
     @dataset_ids = get_all_datasets(self.data_portal.url)
     @dataset_ids.each do |dataset|
       Dataset.create(package_search_title: dataset, city_portal_id: self.id) if !Dataset.find_by(package_search_title: dataset)
     end
  end

  def metric_datasets_sum
    return self.datasets.count
  end

  def metric_non_properitary
    return check_non_properitary.to_f / metric_datasets_sum.to_f * 100.00
  end

  def metric_machine_readable
    return check_machine_readability.to_f / metric_datasets_sum.to_f * 100.00
  end

  def metric_openness
    return check_licenses.to_f / metric_datasets_sum.to_f * 100.00
  end

  def metric_completeness
    return (self.datasets.sum {|f| f.calc_completeness}).to_f / metric_datasets_sum.to_f
  end

  # Zählt die Werte der Kategorien
  def count_categories
    @categories = ENV["CATEGORIES"].split(',')
    @category_count = Hash.new

    @categories.each do |category|
      @category_count[category] = self.datasets.where("'#{category}' = ANY(category)").count
    end
    return @category_count
  end

private

  # nach dem Erstellen eines neuen CityPortals werden alle Datensätze einmal eingelesen.

  def initial_setup
    @dataset_ids = get_all_datasets(self.data_portal.url)
    @dataset_ids.each do |dataset|
      Dataset.create(package_search_title: dataset, city_portal_id: self.id)
    end
  end

  def check_non_properitary
    count_non_properitary = 0
    self.datasets.each do |f|
      count_non_properitary += 1 if f.non_proprietary
    end
    return count_non_properitary
  end

  def check_machine_readability
    count_machine_readability = 0
    self.datasets.each do |f|
      count_machine_readability += 1 if f.machine_readable
    end
    return count_machine_readability
  end

  def check_licenses
    count_open_licenses = 0
    self.datasets.each do |f|
      count_open_licenses += 1 if f.openness
    end
    return count_open_licenses
  end
end
