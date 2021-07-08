class Stage < ApplicationRecord
  has_many :schedules, through: :stage_schedules
  has_many :stage_schedules

  validates :title, presence: true, length: { maximum: 20 }
end
