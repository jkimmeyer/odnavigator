class AddCityReferenceToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_reference :data_portals, :city, foreign_key: true
  end
end
