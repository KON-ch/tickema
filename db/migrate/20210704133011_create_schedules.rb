class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.time :start_time, null: false
      t.date :staging_date, null: false

      t.timestamps
    end

    add_index :schedules, [:start_time, :staging_date], unique: true
  end
end
