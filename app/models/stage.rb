class Stage < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :schedules, through: :stage_schedules

  validates :title, presence: true, length: { maximum: 20 }
end
