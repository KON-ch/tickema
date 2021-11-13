class ChangeIndexIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_index :customers, [:id, :user_id]
  end
end
