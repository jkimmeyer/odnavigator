# CKAN Klasse mit Base URL
# Dann auf diese Base URL verlängern um die Requests zu starten
# - Einmal alle Datensätze abfragen - Unterscheiden zwischen Seiten und alle
# - Einmal die aktuellsten Datensätze abfragen
# - Spezifische Datensätze abfragen

module Harvester
  include HashSearch

  def get_recently_updated_datasets(base_url)
    return handle_request(URI.encode(base_url + '/revision_list'))
  end

# does not work on all dkan portals - so the choose below should be used.
  def get_all_datasets_and_resources(base_url)
    return handle_request(URI.encode(base_url + '/current_package_list_with_ressources'))
  end

  def get_all_datasets(base_url)
    return handle_request(URI.encode(base_url + '/package_list'))
    # get_dataset_details(base_url, datasetId)
  end

  def get_dataset_details(base_url, id)
    response = handle_request(URI.encode(base_url + '/package_show?id=' + id))
    if response.is_a? Array
      return response.first
    else
      return response
    end  
  end
end

private
  def handle_request(request_url)
    begin
      response = HTTParty.get(request_url)
    rescue HTTParty::Error
      "Connection Error"
    rescue StandardError
      "Connection Error"
    else
      if response.code < 300
        return nested_hash_value(JSON.parse(response.body), 'result')
      else
        puts "Server returns a #{response.code} Status Code."
        return response.code
      end
    end
  end
