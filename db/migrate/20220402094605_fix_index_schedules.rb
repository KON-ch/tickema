class FixIndexSchedules < ActiveRecord::Migration[6.1]
  def change
    remove_index :schedules, ["staged_at", "staged_on"], name: "index_schedules_on_staged_at_and_staged_on", unique: true
    remove_index :schedules, ["staged_at"], name: "index_schedules_on_staged_at"
    remove_index :schedules, ["staged_on"], name: "index_schedules_on_staged_on"
    add_index :schedules, %i[staged_on staged_at], order: { staged_on: :asc, staged_at: :asc }
  end
end
