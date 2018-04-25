class CreateCitySnapshotMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :city_snapshot_metrics, {:id => false} do |t|
      t.references :city
      t.date :date
      t.integer :sum_of_datasets
      t.float :total_quality
      t.float :format_quality
      t.float :openness_quality
      t.float :completeness_quality
      t.json :category_counts
      t.float :access_quality
      t.timestamps
    end
    execute "ALTER TABLE city_snapshot_metrics ADD PRIMARY KEY (city_id, date);"
  end
end
