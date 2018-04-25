class AddMissingKeysToDataset < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :missing_keys, :text, array: true, default: []
  end
end
