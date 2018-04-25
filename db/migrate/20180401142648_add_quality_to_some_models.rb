class AddQualityToSomeModels < ActiveRecord::Migration[5.1]
  def change
    add_column :data_portals, :quality, :integer
    add_column :cities, :quality, :integer
  end
end
