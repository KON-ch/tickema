class RemoveStageIdToTicket < ActiveRecord::Migration[6.1]
  remove_index :tickets, [:stage_id, :schedule_id, :customer_id],
    name: "index_tickets_on_stage_id_and_schedule_id_and_customer_id", unique: true

  def change
    remove_column :tickets, :stage_id, :references, null: false
  end

end
