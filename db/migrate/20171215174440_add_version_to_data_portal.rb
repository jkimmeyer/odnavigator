class AddVersionToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :version, :string
  end
end
