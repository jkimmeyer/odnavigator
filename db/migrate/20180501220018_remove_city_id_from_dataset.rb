class RemoveCityIdFromDataset < ActiveRecord::Migration[5.1]
  def change
    remove_reference :datasets, :city
  end
end
