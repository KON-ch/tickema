class AddIndexIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_index :customers, :id
  end
end
