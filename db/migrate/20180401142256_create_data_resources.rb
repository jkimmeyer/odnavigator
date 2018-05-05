class CreateDataResources < ActiveRecord::Migration[5.1]
  def change
    create_table :data_resources do |t|
      t.string :unique_identifier, :unique => true
      t.string :title
      t.string :format
      t.string :url
      t.timestamps
    end
  end
end
