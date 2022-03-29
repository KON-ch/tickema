class RemoveCountToTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :count, :integer, default: 1, null: false
  end
end
