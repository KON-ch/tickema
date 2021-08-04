class AddCustomerRefToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :customer, null: false, foreign_key: true, index: { unique: true }
  end
end
