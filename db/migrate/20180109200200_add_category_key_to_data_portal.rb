class AddCategoryKeyToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :category_key, :string
  end
end
