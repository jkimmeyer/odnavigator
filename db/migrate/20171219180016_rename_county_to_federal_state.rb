class RenameCountyToFederalState < ActiveRecord::Migration[5.1]
  def change
    rename_table :counties, :federal_states
  end
end
