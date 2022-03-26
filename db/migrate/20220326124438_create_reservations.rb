class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :status, default: 0, null: false
      t.integer :count, default: 1, null: false
      t.references :user, foreign_key: true, null: false, index: false
      t.references :ticket, foreign_key: true, null: false, index: false

      t.timestamps
    end

    add_index :reservations, :status
  end
end
