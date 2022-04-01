class AddScheduleAndCustomerToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :schedule, foreign_key: true, index: false
    add_reference :reservations, :customer, foreign_key: true, index: false
  end
end
