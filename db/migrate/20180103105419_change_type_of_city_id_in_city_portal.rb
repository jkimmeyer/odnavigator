class ChangeTypeOfCityIdInCityPortal < ActiveRecord::Migration[5.1]
  def change
    change_column :city_portals, :city_id, :bigint
  end
end
