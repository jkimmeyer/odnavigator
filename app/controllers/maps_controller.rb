class MapsController < ApplicationController
  def index
    # Regenerate the GEOJSON feature collections
    metadata = FeatureCollection.find_by(referencing: "FederalStates")
    features = []

    # Add the features of all federal_states
    CityFeature.all.each do |federal_state|
      features << federal_state.feature
    end

    # FeatureCollection is passed to the view
    @feature_collection = Hash.new
    @feature_collection = metadata.metadata
    @feature_collection["features"] = features

    #FederalStateValues are the sum of the datasets per federal_state. Also passed to the view
    federal_state_datasets = Hash.new
    City.all.each do |federal_state|
      federal_state_datasets[federal_state.name] = federal_state.sum_up_datasets
    end

    @federal_states_values = Hash.new
    federal_state_datasets.each do |key, value|
      @federal_states_values[key] = value.to_f/federal_state_datasets.values.max * 100
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
    metadata = FeatureCollection.find_by(referencing: "Cities")
    CityFeature.where(city_id: City.where("federal_state_id = #{params[:id]}").ids).each do |city|
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
