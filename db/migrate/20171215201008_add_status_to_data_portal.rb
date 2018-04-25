class AddStatusToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :status, :string
  end
end
