class MainController < ApplicationController
  def index
    @cities = City.all
    CityPortal.all.each do |portal|
      portal.get_all_request
    end
  end
end
