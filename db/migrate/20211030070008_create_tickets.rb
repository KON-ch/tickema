class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :stage, foreign_key: true, null: false, index: false
      t.references :schedule, foreign_key: true, null: false, index: false
      t.references :customer, foreign_key: true, null: false, index: false

      t.timestamps
    end
  end
end
