class AddAttributesToDatasets < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :title, :string
    add_column :datasets, :url, :string
    add_column :datasets, :quality, :integer
  end
end
