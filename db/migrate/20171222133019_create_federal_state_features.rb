class CreateFederalStateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :federal_state_features do |t|
      t.json :feature
      t.references :federal_state

      t.timestamps
    end
  end
end
