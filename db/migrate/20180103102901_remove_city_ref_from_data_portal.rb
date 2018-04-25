class RemoveCityRefFromDataPortal < ActiveRecord::Migration[5.1]
  def change
    remove_reference :data_portals, :city, index: true, foreign_key: true
  end
end
