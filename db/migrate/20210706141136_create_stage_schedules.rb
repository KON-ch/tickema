class CreateStageSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :stage_schedules do |t|
      t.references :stage, foreign_key: true, null: false, index: false
      t.references :schedule, foreign_key: true, null: false, index: false

      t.timestamps
    end

    add_index :stage_schedules, [:stage_id, :schedule_id], unique: true
  end
end
