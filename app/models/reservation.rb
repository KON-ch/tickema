class Reservation < ApplicationRecord
  STATUS = { reserved: 0, applied: 1, notified: 2, finished: 3 }

  belongs_to :user
  belongs_to :ticket

  enum status: STATUS

  validates :status, presence: true
  validates :count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  delegate :customer_name, :date, :time, to: :ticket
end
