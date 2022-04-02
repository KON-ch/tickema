class ChangeIndexToCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_index :customers, ["id", "user_id"], name: "index_customers_on_id_and_user_id"
    remove_index :customers, ["id"], name: "index_customers_on_id"
    add_index :customers, %i[name user_id]
  end
end
