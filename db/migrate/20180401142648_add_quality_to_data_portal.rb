class AddQualityToDataPortal < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :quality, :integer
  end
end
