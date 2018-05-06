module Api
  class ProgressController < ApplicationController
    def index
      render json: {number_of_cities: City.count, number_of_cities_with_data_portal: CityPortal.count}
    end
  end
end
