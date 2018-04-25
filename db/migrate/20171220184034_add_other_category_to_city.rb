class AddOtherCategoryToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :other, :integer
  end
end
