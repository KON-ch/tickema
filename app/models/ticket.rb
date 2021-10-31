class Ticket < ApplicationRecord
  belongs_to :stage
  belongs_to :schedule
  belongs_to :customer

  has_one :contact, dependent: :destroy

  delegate :name, to: :customer, prefix: true
  delegate :staged_at, to: :schedule
  delegate :staged_on, to: :schedule

  after_create :_create_contact
  after_destroy :_destroy_customer

  def data
    {
      id:            id,
      customer_id:   customer_id,
      customer_name: customer_name,
      schedule_id:   schedule_id,
      date:          staged_on,
      time:          staged_at,
      count:         count,
      contact_id:    contact.id,
      status:        contact.status,
    }
  end

  private

  def _destroy_customer
    customer.destroy! if customer.tickets.blank?
  end

  def _create_contact
    create_contact(user_id: customer.user.id)
  end
end
