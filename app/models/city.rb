class City < ApplicationRecord
  has_one :federal_state
  has_many :city_portals, :dependent => :destroy
  has_many :data_portals, :through => :city_portals
  has_many :city_snapshot_metrics

  validates_uniqueness_of :name
  validates_presence_of :name

end
