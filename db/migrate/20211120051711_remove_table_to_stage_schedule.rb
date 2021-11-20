class RemoveTableToStageSchedule < ActiveRecord::Migration[6.1]
  def change
    drop_table :stage_schedules do |t|
      t.bigint "stage_id", null: false
      t.bigint "schedule_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
