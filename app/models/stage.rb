class Stage < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :schedules, -> { order(%i[staged_on staged_at]) }, through: :stage_schedules
  has_many :tickets, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }

  def set_schedules
    schedules.map { |schedule| schedule.data(stage_id: id) }
  end
end
