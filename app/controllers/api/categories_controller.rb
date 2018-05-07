module Api
  class CategoriesController < ApplicationController
    def index
      render json: {categories: ENV["CATEGORIES"].split(',')}
    end
  end
end
