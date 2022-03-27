class Stage < ApplicationRecord
  has_many :schedules, -> { order(%i[staged_on staged_at]) }, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }

  def start_date
    schedules.first.staged_on
  end

  def end_date
    schedules.last.staged_on
  end

  def tickets
    schedules.includes(:tickets).map do |schedule|
      schedule.tickets
    end.flatten
  end

  def tickets_count
    count = 0

    tickets.each do |ticket|
      count += ticket.count
    end

    count
  end
end
