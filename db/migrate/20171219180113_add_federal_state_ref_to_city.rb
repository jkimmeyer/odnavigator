class AddFederalStateRefToCity < ActiveRecord::Migration[5.1]
  def change
    add_reference :cities, :federal_state, foreign_key: true
  end
end
