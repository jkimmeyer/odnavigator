class CreateApiRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :api_requests do |t|
      t.timestamps null: false
      t.text :url, null: false # Use text in case of long strings, because strings limited to 255 chars.
    end

    add_index :api_requests, :url, unique: true # Improves performance of future lookups and enforce uniqueness of the URL
  end
end
