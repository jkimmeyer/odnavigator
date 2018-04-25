class RemoveCoveredCitiesFromDataPortals < ActiveRecord::Migration[5.1]
  def change
    remove_column :data_portals, :covered_cities
  end
end
