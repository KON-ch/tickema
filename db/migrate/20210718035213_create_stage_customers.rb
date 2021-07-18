class CreateStageCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :stage_customers do |t|
      t.references :stage_schedule, foreign_key: true, null: false, index: false
      t.references :customer, foreign_key: true, null: false, index: false

      t.timestamps
    end

    add_index :stage_customers, [:stage_schedule_id, :customer_id], unique: true
  end
end
