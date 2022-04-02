class Reservation < ApplicationRecord
  STATUS = { reserved: 0, applied: 1, notified: 2, finished: 3 }

  enum status: STATUS

  belongs_to :schedule
  belongs_to :customer

  validates :status, presence: true
  validates :count, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :for_stage, -> (stage_id, user_id) do
    joins(:schedule, :customer)
    .where("schedule.stage_id" => stage_id, "customer.user_id" => user_id)
  end

  delegate :staged_on, :staged_at, to: :schedule
  alias_method :date, :staged_on
  alias_method :time, :staged_at

  # def customer_name; customer.name; end
  delegate :name, to: :customer, prefix: true

  after_destroy :confirm_reservation

  # customer.destory! if customer.reservation.blank?
  delegate :confirm_reservation, to: :customer
end
