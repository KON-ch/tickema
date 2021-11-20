class AddStageIdToSchedule < ActiveRecord::Migration[6.1]
  def change
    add_reference :schedules, :stage, foreign_key: true
  end
end
