class AddResultStoreToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :result_store_key, :string
  end
end
