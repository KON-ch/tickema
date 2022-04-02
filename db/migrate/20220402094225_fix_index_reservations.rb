class FixIndexReservations < ActiveRecord::Migration[6.1]
  def change
    remove_index :reservations, :status, name: "index_reservations_on_status"
    add_index :reservations, %i[customer_id schedule_id]
    add_index :reservations, %i[schedule_id customer_id]
  end
end
