class AddCountColumnToTicket < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :count, :integer, null: false, default: 1
  end
end
