class CreateDatasets < ActiveRecord::Migration[5.1]
  def change
    create_table :datasets do |t|
      t.string :dataset_id, :unique => true
      t.text :category, array: true, default: []
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
