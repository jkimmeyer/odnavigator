class AlterDataPortal < ActiveRecord::Migration[5.1]
  def change
    change_column :data_portals, :quality, :decimal
    add_column :data_portals, :sum_of_datasets, :integer
    add_column :data_portals, :format_quality, :decimal
    add_column :data_portals, :openness_quality, :decimal
    add_column :data_portals, :access_quality, :decimal
    add_column :data_portals, :completeness_quality, :decimal
    add_column :data_portals, :category_counts, :json
    remove_column :data_portals, :version
    remove_column :data_portals, :result_store_key
    remove_column :data_portals, :category_key
  end
end
