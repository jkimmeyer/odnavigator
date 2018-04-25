class CreateFeatureCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :feature_collections do |t|
      t.json :metadata

      t.timestamps
    end
  end
end
