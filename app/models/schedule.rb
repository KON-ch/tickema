class Schedule < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :stages, through: :stage_schedules

  validates :start_time, presence: true
  validates :staging_date, presence: true

  after_save :create_stage_schedule

  attr_accessor :stage_id

  private

  def create_stage_schedule
    stage_schedules.create(schedule_id: id, stage_id: stage_id)
  end
end
