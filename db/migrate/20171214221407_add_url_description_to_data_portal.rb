class AddUrlDescriptionToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :url, :string
    add_column :data_portals, :description, :string
  end
end
