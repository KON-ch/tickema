class RemoveContactTable < ActiveRecord::Migration[6.1]
  def change
    remove_index :contacts, :id, name: "index_contacts_on_id"

    drop_table "contacts" do |t|
      t.integer "status", default: 0, null: false
      t.references "ticket_id", null: false
      t.references "user_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
