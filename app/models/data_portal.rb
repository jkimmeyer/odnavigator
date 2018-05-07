class DataPortal < ApplicationRecord
  extend Enumerize
  CACHE_POLICY = lambda { 3.day.ago }

  # Use has_many instead of has_and_belongs_to_many because now i can do cool things on the city_portals model
  has_many :city_portals, :dependent => :destroy
  has_many :cities, :through => :city_portals

  accepts_nested_attributes_for :cities

  # Status can just take one of these states.
  enumerize :status, in: %w[pending accepted rejected], default: 'pending'
  validates_presence_of :name, :url, :search_param
  validates_uniqueness_of :url

  def current_metric(metric)
    if metric == 'sum_of_datasets'
      return (self[metric] / DataPortal.all.map(&:sum_of_datasets).max.to_f * 100.00).round(2)
    else
      return self[metric]
    end
  end

  def details
    return self
  end

private
end
