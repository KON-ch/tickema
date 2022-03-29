class Ticket < ApplicationRecord
  belongs_to :schedule
  belongs_to :customer

  belongs_to :user
  delegate :user, :user_id, to: :customer

  belongs_to :stage
  delegate :stage, to: :schedule

  has_one :reservation, dependent: :destroy

  scope :for_stage,
    -> (user_id, stage_id) do
      joins(:customer, :schedule)
      .where("customer.user_id" => user_id, "schedule.stage_id" => stage_id)
    end

  delegate :name, to: :customer, prefix: true

  delegate :staged_on, :staged_at, to: :schedule
  alias_method :date, :staged_on
  alias_method :time, :staged_at

  delegate :id, to: :reservation, prefix: true
  delegate :status, to: :reservation

  after_create :_create_reservation
  after_destroy :_comfirm_customer_exist

  private

  def _comfirm_customer_exist
    customer.destroy! if customer.tickets.blank?
  end

  def _create_reservation
    create_reservation(user_id: customer.user.id)
  end
end
