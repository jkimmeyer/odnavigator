class AddReferenceToApiRequest < ActiveRecord::Migration[5.1]
  def change
    add_reference :api_requests, :data_portal, index: true
  end
end
