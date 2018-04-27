class AddMaintainerToDataset < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :maintainer, :string
  end
end
