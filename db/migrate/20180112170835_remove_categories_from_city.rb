class RemoveCategoriesFromCity < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :just
    remove_column :cities, :heal
    remove_column :cities, :gove
    remove_column :cities, :tran
    remove_column :cities, :soci
    remove_column :cities, :envi
    remove_column :cities, :tech
    remove_column :cities, :econ
    remove_column :cities, :educ
  end
end
