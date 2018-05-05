class AddAttributesToDataResources < ActiveRecord::Migration[5.1]
  def change
    add_column :data_resources, :year, :integer
    add_reference :data_resources, :dataset, index: true
  end
end
