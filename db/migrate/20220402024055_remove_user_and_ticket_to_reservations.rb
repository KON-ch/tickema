class RemoveUserAndTicketToReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :user_id, :references, null: false
    remove_column :reservations, :ticket_id, :references, null: false
  end
end
