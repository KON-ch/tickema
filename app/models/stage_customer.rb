class StageCustomer < ApplicationRecord
  belongs_to :stage_schedule
  belongs_to :customer

  validates :stage_schedule_id, presence: true
  validates :customer_id, presence: true

  after_destroy :destroy_customer

  private

  def destroy_customer
    customer.destroy! if customer.stage_schedules.blank?
  end
end
