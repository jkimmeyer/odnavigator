class AddLicenseToDataset < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :license, :string
  end
end
