module Api
  class CitiesController < ApplicationController
    def index
      render json: {cities: City.all.map { |e| e.name }}
    end
  end
end
