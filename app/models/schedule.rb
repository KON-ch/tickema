class Schedule < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :stages, through: :stage_schedules

  validates :start_time, presence: true
  validates :staging_date, presence: true

  after_save :create_stage_schedule

  attr_accessor :stage_id

  def data(stage_id:)
    {
      id:           stage_schedule_id(stage_id: stage_id),
      staging_date: staging_date,
      start_time:   start_time
    }
  end

  def staging_date
    super&.strftime("%m月%d日")
  end

  def start_time
    super&.strftime("%H:%M")
  end

  private

  def stage_schedule_id(stage_id:)
    stage_schedules.find_by(stage_id: stage_id).id
  end

  def create_stage_schedule
    stage_schedules.create(schedule_id: id, stage_id: stage_id)
  end
end
