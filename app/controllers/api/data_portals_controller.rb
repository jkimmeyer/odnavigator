module Api
  class DataPortalsController < ApplicationController

    def markers
      @city_metrics = Hash.new
      CityPortal.all.each do |f|
        @city_metrics[f.city.name] = f.data_portal.current_metric(metric_param) || 0
      end
      render json: @city_metrics
    end

    def index
    end

    def details
      @data_portal = City.find_by(name: city_param).city_portals.first.data_portal
      render json:  @data_portal.details
    end
  end
end

private
def metric_param
  @metric ||= params[:metric]
end

def city_param
  @city ||= params[:city]
end
