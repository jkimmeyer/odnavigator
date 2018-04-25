class ApiRequest < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  # Caching got from https://robots.thoughtbot.com/caching-api-requests
  # Overwrites Class Method and calls the instance method after.
  def self.cache(url, cache_policy)
    # calls the new action of data_portals in the controller if url does not exist. Calls the cache Method for the Instance.
    find_or_initialize_by(url: url).cache(cache_policy) do
      if block_given?
        yield
      end
    end
  end

  # instance method
  def cache(cache_policy)
    # Just apply changes if there is a new record or last update is older than cache policy.
    #if new_record? || updated_at < cache_policy.call
      update_attributes(updated_at: Time.zone.now)
      yield
    #else
    #  puts "Cached!"
    #end
  end
end
