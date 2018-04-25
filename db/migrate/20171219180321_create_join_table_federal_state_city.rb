class CreateJoinTableFederalStateCity < ActiveRecord::Migration[5.1]
  def change
    create_join_table :federal_states, :cities do |t|
      # t.index [:federal_state_id, :city_id]
      # t.index [:city_id, :federal_state_id]
    end
  end
end
