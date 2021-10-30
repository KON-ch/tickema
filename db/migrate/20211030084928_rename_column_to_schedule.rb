class RenameColumnToSchedule < ActiveRecord::Migration[6.1]
  def change
    rename_column :schedules, :start_time, :staged_at
    rename_column :schedules, :staging_date, :staged_on
  end
end
