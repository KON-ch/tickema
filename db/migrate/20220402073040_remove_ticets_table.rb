class RemoveTicetsTable < ActiveRecord::Migration[6.1]
  remove_index :tickets, :id, name: :index_tickets_on_id

  def change
    drop_table :tickets do |t|
      t.references "schedule_id", null: false
      t.references "customer_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
