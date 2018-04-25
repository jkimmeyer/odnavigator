class DataPortalsController < ApplicationController
  def index
    @data_portals = DataPortal.all
  end

  def new
    @data_portal = DataPortal.new
  end

  #TODO Create City Reference.
  def create
    @data_portal = DataPortal.new(data_portal_params)
    # Need to create CityPortal also:
    if @data_portal.save
      redirect_to data_portals_path
    else
      render 'new'
    end
  end

  def edit
    @data_portal = DataPortal.find(params[:id])
  end

  #TODO Create City Reference.
  def update
    @data_portal = DataPortal.find(params[:id])
    if @data_portal.update_attributes(data_portal_params)
      redirect_to data_portals_path
    else
      render 'edit'
    end
  end

  private
    def data_portal_params
      params.require(:data_portal).permit(:url, :name, :description, :search_param, :version, :status, :result_store_key, :category_key, :city_ids => [])
    end
end
