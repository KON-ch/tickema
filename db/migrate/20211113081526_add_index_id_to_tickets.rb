class AddIndexIdToTickets < ActiveRecord::Migration[6.1]
  def change
    add_index :tickets, :id
  end
end
