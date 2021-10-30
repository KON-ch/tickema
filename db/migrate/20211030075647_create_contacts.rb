class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :status, null: false, default: 0
      t.references :ticket, foreign_key: true, null: false, index: false
      t.references :user, foreign_key: true, null: false, index: false

      t.timestamps
    end
  end
end
