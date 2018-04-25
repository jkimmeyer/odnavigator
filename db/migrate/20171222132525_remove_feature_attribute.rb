class RemoveFeatureAttribute < ActiveRecord::Migration[5.1]
  def change
    remove_column :federal_states, :feature
    remove_column :cities, :feature
  end
end
