class AddAttributesToDataResources < ActiveRecord::Migration[5.1]
  def change
    add_column :data_resources, :formats, :string, array: true, default: []
    add_column :data_resources, :year, :integer
    add_column :data_resources, :licenses, :string, array: true, default: []
    remove_column :data_resources, :format
    remove_column :data_resources, :license
    add_reference :data_resources, :dataset, index: true
  end
end
