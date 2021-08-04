class AddUserRefToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_reference :customers, :user, null: false, foreign_key: true, index: { unique: true }
  end
end
