class StageCustomer < ApplicationRecord
  belongs_to :stage_schedule
  belongs_to :customer

  validates :stage_schedule_id, presence: true
  validates :customer_id, presence: true

  after_save :create_ticket
  after_destroy :destroy_customer

  private

  def destroy_customer
    customer.destroy! if customer.stage_schedules.blank?
  end

  def create_ticket
    stage_schedule = StageSchedule.find(stage_schedule_id)
    Ticket.create(stage_id: stage_schedule.stage_id, schedule_id: stage_schedule.schedule_id, customer_id: customer_id)
  end
end
