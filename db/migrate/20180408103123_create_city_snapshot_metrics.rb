class CreateCitySnapshotMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :city_snapshot_metrics, {:id => false} do |t|
      t.references :city
      t.datetime :ref_date
      t.integer :sum_of_datasets
      t.decimal :total_quality
      t.decimal :format_quality
      t.decimal :openness_quality
      t.decimal :completeness_quality
      t.json :category_counts
      t.decimal :access_quality
      t.timestamps
    end
    execute "ALTER TABLE city_snapshot_metrics ADD PRIMARY KEY (city_id, ref_date);"
  end
end
