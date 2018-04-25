class AddSearchParamToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :search_param, :string
  end
end
