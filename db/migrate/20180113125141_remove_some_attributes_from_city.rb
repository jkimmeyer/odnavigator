class RemoveSomeAttributesFromCity < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :bevoelkerung
    remove_column :cities, :other
    remove_column :cities, :total_count
  end
end
