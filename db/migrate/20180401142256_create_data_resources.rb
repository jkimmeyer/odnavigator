class CreateDataResources < ActiveRecord::Migration[5.1]
  def change
    create_table :data_resources do |t|
      t.string :data_resources_id
      t.string :title
      t.string :license
      t.string :format
      t.string :url
      t.references :datasets
      t.timestamps
    end
  end
end
