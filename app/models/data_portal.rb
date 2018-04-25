class DataPortal < ApplicationRecord
  extend Enumerize
  CACHE_POLICY = lambda { 3.day.ago }

  # Use has_many instead of has_and_belongs_to_many because now i can do cool things on the city_portals model
  has_many :city_portals, :dependent => :destroy
  has_many :cities, :through => :city_portals

  accepts_nested_attributes_for :cities

  # Status can just take one of these states.
  enumerize :status, in: %w[pending accepted rejected], default: 'pending'
  validates_presence_of :name, :url, :description, :search_param, :result_store_key
  validates_uniqueness_of :url

  # Check if API is avaiable.
  def check_avaiability
    request_url = self.url + '/site_read'
    ApiRequest.cache(request_url, CACHE_POLICY) do
      begin
        response = HTTParty.get(request_url)
      rescue HTTParty::Error
        update_attribute(:avaiability, false)
      rescue StandardError
        update_attribute(:avaiability, false)
      else
        update_attribute(:avaiability, response["result"]) if response.code < 400
      end
    end
    self.avaiability
  end

private
end
