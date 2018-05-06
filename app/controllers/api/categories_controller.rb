module Api
  class CategoriesController < ApplicationController
    def index
      puts ENV["CATEGORIES"]
      render json: {categories: ENV["CATEGORIES"].split(',')}
    end
  end
end
