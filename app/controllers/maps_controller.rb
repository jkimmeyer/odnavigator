class MapsController < ApplicationController
  def index
    # Regenerate the GEOJSON feature collections
    metadata = {"type"=>"FeatureCollection", "crs"=>{"type"=>"name", "properties"=>{"name"=>"urn:ogc:def:crs:OGC:1.3:CRS84"}}, "source"=>"© GeoBasis-DE / BKG 2013 (Daten verändert)"}
    features = []

    # Add the features of all federal_states
    City.all.each do |city|
      features << city.feature
    end

    # FeatureCollection is passed to the view
    @feature_collection = Hash.new
    @feature_collection = metadata
    @feature_collection["features"] = features

    #FederalStateValues are the sum of the datasets per federal_state. Also passed to the view
    city_datasets = Hash.new
    City.all.each do |city|
      city_datasets[city.name] = 0
    end

    @city_values = Hash.new
    city_datasets.each do |city, metric|
      @city_values[city] = metric.to_f/city_datasets.values.max * 100
    end

    puts @federal_states_values
    # respond_to do |format|
    #   format.json { render :json => {:federal_state_values => @federal_state_values }}
    # end
  end

  def request_categories
      @city_portals = CityPortal.all
      @city_portals.each do |city_portal|
        city_portal.get_category
      end
  end

  def show
    # TODO Refactor metrics etc. to Helper Methods.
    # Same as above(#index), but for the citys of a federal_state.
    cities = []
    metadata = {"type"=>"FeatureCollection", "crs"=>{"type"=>"name", "properties"=>{"name"=>"urn:ogc:def:crs:OGC:1.3:CRS84"}}, "source"=>"© GeoBasis-DE / BKG 2013 (Daten verändert)"}
    City.where(city_id: City.where("federal_state_id = #{params[:id]}").ids).each do |city|
      cities << city.feature
    end

    @feature_collection = Hash.new
    @feature_collection = metadata.metadata
    @feature_collection["features"] = cities

    # Calculates the sum of datasets for every city of a federal_state.
    cities_datasets = Hash.new
    City.where("federal_state_id = #{params[:id]}").each do |city|
      cities_datasets[city.name] = city.sum_up_datasets
    end

    # Metric to calculate the share of datasets.
    @city_values = Hash.new
    cities_datasets.each do |key, value|
      @city_values[key] = value.to_f/cities_datasets.values.max * 100
    end

    respond_to do |format|
      # Needs to respond to Json to load the data asnyc.
      format.json { render :json => { :feature_collection => @feature_collection,
        :city_values => @city_values }}
    end

    def get_category_values
      # TODO Implement for cities and federal_states(modulize the code) & Add "other" - category
      cities_datasets = Hash.new
      City.all.each do |city|
        cities_datasets[city.name] = city.datasets.where("'#{params[:category]}' = ANY (category)").count
      end

      # Same Metric as above. Refactor.
      @city_values = Hash.new
      cities_datasets.each do |key, value|
        @city_values[key] = value.to_f/cities_datasets.values.max * 100
      end

      respond_to do |format|
        format.json { render :json => {:city_values => @city_values }}
      end
    end

  end
end
