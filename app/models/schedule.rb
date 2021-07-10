class Schedule < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :stages, through: :stage_schedules

  validates :start_time, presence: true
  validates :staging_date, presence: true
end
