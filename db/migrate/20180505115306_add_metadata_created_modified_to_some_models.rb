class AddMetadataCreatedModifiedToSomeModels < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :metadata_created, :datetime
    add_column :datasets, :metadata_modified, :datetime

    add_column :data_resources, :metadata_created, :datetime
    add_column :data_resources, :metadata_modified, :datetime
  end
end
