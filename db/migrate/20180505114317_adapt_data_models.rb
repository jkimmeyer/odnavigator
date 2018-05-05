class AdaptDataModels < ActiveRecord::Migration[5.1]
  def change
    change_column :datasets, :quality, :decimal
    add_column :datasets, :completeness, :decimal
    remove_column :data_resources, :year
  end
end
