class FederalStateFeature < ApplicationRecord
  belongs_to :federal_state
  validates_uniqueness_of :debkg_id
end
