class AddAvaiabilityToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :avaiability, :boolean
  end
end
