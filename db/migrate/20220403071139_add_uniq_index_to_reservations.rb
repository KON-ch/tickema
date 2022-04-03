class AddUniqIndexToReservations < ActiveRecord::Migration[6.1]
  def change
    remove_index :reservations, %i[customer_id schedule_id]
    remove_index :reservations, %i[schedule_id customer_id]
    add_index :reservations, %i[customer_id schedule_id], unique: true
    add_index :reservations, %i[schedule_id customer_id], unique: true
  end
end
