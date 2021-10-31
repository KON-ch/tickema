class AddIndexToTicket < ActiveRecord::Migration[6.1]
  def change
    add_index :tickets, [:stage_id, :schedule_id, :customer_id], unique: true
  end
end
