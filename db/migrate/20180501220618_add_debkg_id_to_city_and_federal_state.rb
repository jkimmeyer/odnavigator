class AddDebkgIdToCityAndFederalState < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :debkg_id, :string
    add_column :federal_states, :debkg_id, :string
  end
end
