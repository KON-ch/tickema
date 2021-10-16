class StageSchedule < ApplicationRecord
  belongs_to :stage
  belongs_to :schedule
  has_many :stage_customers, dependent: :destroy
  has_many :customers, through: :stage_customers

  validates :stage_id, presence: true
  validates :schedule_id, presence: true

  def staging_date
    schedule.staging_date
  end

  def start_time
    schedule.start_time
  end
end
