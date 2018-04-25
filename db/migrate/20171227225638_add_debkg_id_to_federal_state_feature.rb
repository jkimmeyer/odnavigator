class AddDebkgIdToFederalStateFeature < ActiveRecord::Migration[5.1]
  def change
    add_column :federal_state_features, :debkg_id, :string
  end
end
