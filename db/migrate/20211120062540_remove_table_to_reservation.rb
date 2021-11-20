class RemoveTableToReservation < ActiveRecord::Migration[6.1]
  def change
    drop_table :reservations do |t|
      t.references :schedule, foreign_key: true, null: false, index: false
      t.references :customer, foreign_key: true, null: false, index: false
      t.integer :status, default: 0, null: false
      t.integer :count, default: 1, null: false

      t.timestamps
    end
  end
end
