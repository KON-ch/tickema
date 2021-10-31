class RemoveTableToStageCustomer < ActiveRecord::Migration[6.1]
  def change
    remove_index :stage_customers, name: :index_stage_customers_on_stage_schedule_id_and_customer_id

    drop_table :stage_customers do |t|
      t.bigint "stage_schedule_id", null: false
      t.bigint "customer_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "count", default: 1, null: false
      t.boolean "contacted", default: false, null: false
    end
  end
end
