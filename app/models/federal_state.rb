class FederalState < ApplicationRecord
  validates_uniqueness_of :id
  has_many :cities

  # Method executes every time before something is saved.
  before_save :cut_name

  def sum_up_datasets
    sum_of_datasets = 0
    # Iterate through the cities of this federal_state to sum up datasets.
    self.cities.each do |city|
      sum_of_datasets += city.sum_up_datasets
    end
    sum_of_datasets
  end

private
# Some FederalStates have more than one feature. To connect the federal_state with the federal_state features and the datasets you need a definite name.
  def cut_name
    # Safe navigation operator because gsub! can return nil.
    self.name.gsub!(/\(.*\)/, '')&.strip!
  end
end
