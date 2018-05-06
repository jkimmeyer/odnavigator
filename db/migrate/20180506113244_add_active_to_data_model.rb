class AddActiveToDataModel < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :active, :bool
  end
end
