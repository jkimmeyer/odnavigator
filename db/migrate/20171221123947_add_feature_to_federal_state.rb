class AddFeatureToFederalState < ActiveRecord::Migration[5.1]
  def change
    add_column :federal_states, :feature, :json
  end
end
