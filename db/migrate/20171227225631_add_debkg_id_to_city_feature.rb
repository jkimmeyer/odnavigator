class AddDebkgIdToCityFeature < ActiveRecord::Migration[5.1]
  def change
    add_column :city_features, :debkg_id, :string
  end
end
