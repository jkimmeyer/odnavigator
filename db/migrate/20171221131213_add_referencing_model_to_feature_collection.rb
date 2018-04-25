class AddReferencingModelToFeatureCollection < ActiveRecord::Migration[5.1]
  def change
    add_column :feature_collections, :referencing, :string
  end
end
