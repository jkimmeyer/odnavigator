class CreateCityFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :city_features do |t|
      t.json :feature
      t.references :city

      t.timestamps
    end
  end
end
