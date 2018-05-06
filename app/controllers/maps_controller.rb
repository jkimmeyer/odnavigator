class MapsController < ApplicationController
  def index
    # Regenerate the GEOJSON feature collections
    metadata = {"type"=>"FeatureCollection", "crs"=>{"type"=>"name", "properties"=>{"name"=>"urn:ogc:def:crs:OGC:1.3:CRS84"}}, "source"=>"© GeoBasis-DE / BKG 2013 (Daten verändert)"}
    features = []

    # Add the features of all federal_states
    CityPortal.all.each do |city_portal|
      features << city_portal.city.feature
    end

    # FeatureCollection is passed to the view
    @feature_collection = Hash.new
    @feature_collection = metadata
    @feature_collection["features"] = features

    @progress = Hash.new
    @progress['value'] = CityPortal.count
    @progress['max'] = City.count

    @city_values = Hash.new
    CityPortal.all.each do |f|
      @city_values[f.city.name] = f.data_portal.current_metric('quality') || 0
    end
  end

end
