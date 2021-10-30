class Ticket < ApplicationRecord
  belongs_to :stage
  belongs_to :schedule
  belongs_to :customer

  has_one :contact, dependent: :destroy

  after_save :_create_contact

  private

  def _create_contact
    user_id = customer.user.id
    create_contact(user_id: user_id)
  end
end
