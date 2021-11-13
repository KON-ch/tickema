class AddIndexToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_index :schedules, :staged_on
    add_index :schedules, :staged_at
  end
end
