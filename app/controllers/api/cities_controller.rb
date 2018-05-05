module Api
  class CitiesController < ApplicationController
    def metrics
      @city_metrics = Hash.new
      City.all.each do |f|
        @city_metrics[f.name] = f.data_portals.first&.current_metric(metric_param) || 0
      end
      render json: @city_metrics
    end

    def details
      @city = City.find_by(name: city_param).data_portals.first&.details || 0
      render json: @city
    end
  end
end

private
def metric_param
  @metric ||= params[:name]
end

def city_param
  @city ||= params[:city]
end
