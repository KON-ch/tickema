class Schedule < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :stages, through: :stage_schedules
  has_many :tickets, dependent: :nullify

  validates :staged_at, presence: true
  validates :staged_on, presence: true

  after_save :create_stage_schedule

  attr_accessor :stage_id

  def data(stage_id:)
    {
      id:           stage_schedules.find_by(stage_id: stage_id).id,
      staged_on:    staged_on,
      staged_at:    staged_at
    }
  end

  def staged_on
    super&.strftime("%m月%d日")
  end

  def staged_at
    super&.strftime("%H:%M")
  end

  private

  def create_stage_schedule
    stage_schedules.create(schedule_id: id, stage_id: stage_id)
  end
end
