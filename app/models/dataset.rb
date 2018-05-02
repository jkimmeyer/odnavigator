class Dataset < ApplicationRecord
  validates_uniqueness_of :dataset_id
  has_many :data_resources
  # TODO Fix Validation for uniqueness of array element and check if they control category
  #validates :category, inclusion: {in: %w[agri envi heal soci educ ener just tran econ tech regi geo]}
end
