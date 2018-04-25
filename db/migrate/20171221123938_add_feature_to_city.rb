class AddFeatureToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :feature, :json
  end
end
