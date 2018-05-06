class RenameFormatToDataFormat < ActiveRecord::Migration[5.1]
  def change
    rename_column :data_resources, :format, :data_format
  end
end
