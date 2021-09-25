class Stage < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :schedules, -> { order(%i[staging_date start_time]) }, through: :stage_schedules

  validates :title, presence: true, length: { maximum: 20 }

  def set_schedules
    schedules_data = []

    schedules.each do |s|
      stage_schedule_id = stage_schedules.find_by(schedule_id: s.id).id

      schedules_data << {
        id:           stage_schedule_id,
        staging_date: s.staging_date.strftime("%m月%d日"),
        start_time:   s.start_time.strftime("%H:%M")
      }
    end

    schedules_data
  end
end
