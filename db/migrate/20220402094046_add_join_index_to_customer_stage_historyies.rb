class AddJoinIndexToCustomerStageHistoryies < ActiveRecord::Migration[6.1]
  def change
    add_index :customer_stage_histories, %i[customer_id stage_id]
    add_index :customer_stage_histories, %i[stage_id customer_id]
  end
end
