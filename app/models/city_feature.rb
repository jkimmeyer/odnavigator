class CityFeature < ApplicationRecord
  belongs_to :city
  validates_uniqueness_of :debkg_id
end
