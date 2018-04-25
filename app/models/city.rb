class City < ApplicationRecord
  has_one :federal_state
  has_many :datasets
  has_many :city_portals, :dependent => :destroy
  has_many :data_portals, :through => :city_portals

  validates_uniqueness_of :name
  validates_presence_of :name

  # You could also delete this, since its simple logic. Just hold for consistency.
  def sum_up_datasets
    self.datasets.count
  end

end
