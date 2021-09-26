class Stage < ApplicationRecord
  has_many :stage_schedules, dependent: :destroy
  has_many :schedules, -> { order(%i[staging_date start_time]) }, through: :stage_schedules

  validates :title, presence: true, length: { maximum: 20 }

  def set_schedules
    schedules_data = []

    schedules_data.tap {
      stage_schedules.eager_load(:schedule).each do |stage_schedule|
        schedules_data << {
          id:           stage_schedule.id,
          staging_date: stage_schedule.schedule.staging_date.strftime("%m月%d日"),
          start_time:   stage_schedule.schedule.start_time.strftime("%H:%M")
        }
      end
    }
  end
end
