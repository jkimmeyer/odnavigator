class AddCoveredCitiesToDataPortal < ActiveRecord::Migration[5.1]
  def change
    change_table :data_portals do |t|
        t.string :covered_cities, array: true, default: []
    end
  end
end
