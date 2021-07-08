class StageSchedule < ApplicationRecord
  belongs_to :stage
  belongs_to :schedule

  validates :stage_id, presence: true
  validates :schedule_id, presence: true
end
