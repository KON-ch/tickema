class Schedule < ApplicationRecord
  has_many :stages, through: :stage_schedules
  has_many :stage_schedules, dependent: :destroy
  accepts_nested_attributes_for :stage_schedules

  validates :start_time, presence: true
  validates :staging_date, presence: true
end
