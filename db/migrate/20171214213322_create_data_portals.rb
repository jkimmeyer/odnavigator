class CreateDataPortals < ActiveRecord::Migration[5.1]
  def change
    create_table :data_portals do |t|
      t.string :name
      t.timestamps
    end
  end
end
