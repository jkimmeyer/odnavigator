# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Read Geojson File for the 16 states in germany.
file = File.read(File.join(Rails.root, 'app', 'assets', 'files', 'bundeslaender_simplify200.geojson'))
data_hash_federal_states = JSON.parse(file)

# Read Geojson File for all Cities in germany.
file = File.read(File.join(Rails.root, 'app', 'assets', 'files', 'gemeinden_simplify200.geojson'))
data_hash_cities = JSON.parse(file)

# take important metadata of the geojson files that must be avaiable for every city and federal_state.
puts meta_data_federal_states = data_hash_federal_states.reject {|y| y == "features"}
meta_data_cities = data_hash_cities.reject{|y| y== "features"}

# build a Hash with every City that has a population that is bigger than 100.000 people and its appertaining feature
cities_list = Array.new
data_hash_cities["features"].each do |feature|
  if feature["properties"].has_key? "destatis" then
    cities_list << feature if feature["properties"]["destatis"]["population"] > 100000
  end
end

# Create a Model Instance for the Metadata of FederalStates and Citys
# FeatureCollection.create(referencing:"FederalStates", metadata: meta_data_federal_states)
# FeatureCollection.create(referencing:"Cities", metadata: meta_data_cities)

# Create Instance for every FederalState with the feature and the "Regionalschlüssel" as an id
data_hash_federal_states["features"].each do |feature|
  FederalState.create(name: feature["properties"]["GEN"], id: feature["properties"]["RS"].to_i, feature: feature, debkg_id: feature["properties"]["DEBKG_ID"])
end

# Create Instance for every City with the feature and a reference to the "Regionalschlüssel" of the appertaining FederalState"
cities_list.each do |feature|
  City.create(id: feature["properties"]["RS"], name: feature["properties"]["GEN"], federal_state_id: feature["properties"]["RS"][0..1].to_i, feature: feature, debkg_id: feature["properties"]["DEBKG_ID"])
end

# Some default data Portals. So the Application never starts empty.
data_portal_list = [
 [ "http://offenedaten-koeln.de/api/3/action", "Offene Daten Köln", "Open Data Portal der Stadt Köln", "/current_package_list_with_resources"],
 [ "https://opendata.bonn.de/api/3/action", "Offene Daten Bonn", "Open Data Portal der Stadt Bonn", "/current_package_list_with_resources"],
 [ "http://offenedaten.aachen.de/api/3/action", "Offene Daten Aachen", "Open Data Portal der Stadt Aachen", "/current_package_list_with_resources"]
]

# Create the Data Apis.
data_portal_list.each do |url, name, description, search_param|
 DataPortal.create( name: name, url: url, description: description, search_param: search_param)
end

city_portals_list = [
  [ "53150000000", 1 ],
  [ "53140000000", 2 ],
  [ "53340002002", 3 ]
]

city_portals_list.each do |city_id, data_portal_id|
  CityPortal.create( city_id: city_id, data_portal_id: data_portal_id )
end

# Success-Message for a successful process.
puts "Seeds generated!"
