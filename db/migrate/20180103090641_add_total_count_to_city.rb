class AddTotalCountToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :total_count, :integer
  end
end
