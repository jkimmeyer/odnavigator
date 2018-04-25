class CreateCityPortals < ActiveRecord::Migration[5.1]
  def change
    create_table :city_portals do |t|
      t.integer :city_id
      t.integer :data_portal_id

      t.timestamps
    end
  end
end
