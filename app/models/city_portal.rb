class CityPortal < ApplicationRecord

  include HashSearch
  include CategoryMatcher
  include Harmonizer

  belongs_to :city
  belongs_to :data_portal
  CACHE_POLICY = lambda { 3.day.ago }
  validates :city, uniqueness: {scope: :data_portal}

  # Work with yield and modulize this request pattern.
  def get_all_request
    request_url = self.data_portal.url + self.data_portal.search_param
    request_url += self.city.name if self.data_portal.cities.count > 1

    # You can put this also in a module i think.
    ApiRequest.cache(request_url, CACHE_POLICY) do
      begin
        response = HTTParty.get(URI.encode(request_url))
      rescue HTTParty::Error
        "Connection Error"
      rescue StandardError
        "Connection Error"
      else
        if response.code < 300
          recursive_dataset_creation(nested_hash_value(JSON.parse(response.body),
                                                      self.data_portal.result_store_key))
        else
          puts "Server returns a #{response.code} Status Code."
        end
      end
    end
  end

  def get_category
    #TODO Put it into a module
    request_url = self.data_portal.url + self.data_portal.search_param
    request_url += self.city.name if self.data_portal.cities.count > 1

    ApiRequest.cache(request_url, CACHE_POLICY) do
      begin
        response = HTTParty.get(URI.encode(request_url))
      rescue HTTParty::Error
        #TODO Place a better Errorhandling
        puts "Connection Error"
      rescue StandardError
        puts "Connection Error"
      else
        if response.code < 400 then
          # TODO simplify
          datasets = nested_hash_value(JSON.parse(response.body), self.data_portal.result_store_key)
          # the cologne api stores his datasets in an array, thats include exactly one element thats an array. Problem needs to be solved on an other way, for now its ok.
          datasets = datasets.first if self.data_portal_id == 2

          datasets.each do |dataset|
            if nested_hash_value(dataset, self.data_portal.category_key) then
              #iterates through every element, thats in the category_key
              nested_hash_value(dataset, self.data_portal.category_key).each do |category|
                if get_groups_of_dataset(category).present? then
                  @dataset = Dataset.find_by(dataset_id: dataset["id"])
                  # needs to be solved like this, cause psql array is not that easy to fill. Could reference a new Category model instead. But for now its ok.
                  @dataset.category << get_groups_of_dataset(category)
                  @dataset.save
                end
              end
            end
          end
        end
      end
    end
    return "Finished!"
  end
end

private

# Creates a new dataset for every open data resource
def recursive_dataset_creation(result)
  if result.nil?
    return "Nothing do do here"
  end
  result.each do |package|
    # The result fo some CKAN APIs is stored in two arrays, so you need to check if its a hash. If not, it checks recursive every element in the deeper array.
    if package.is_a? Hash then
      # TODO Include category
      #Dataset.create(dataset_id: package["id"], city_id: self.city_id)
      harmonize_dataset(package, self.city_id)
    else
      recursive_dataset_creation(package)
    end
  end
end
