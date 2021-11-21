class Ticket < ApplicationRecord
  include ActiveModel::Serialization

  belongs_to :stage
  belongs_to :schedule
  belongs_to :customer

  has_one :contact, dependent: :destroy

  validates :count, presence: true, numericality: { greater_than: 0 }

  delegate :name, to: :customer, prefix: true
  delegate :user_id, to: :customer

  delegate :staged_on, to: :schedule
  alias_method :date, :staged_on

  delegate :staged_at, to: :schedule
  alias_method :time, :staged_at

  delegate :id, to: :contact, prefix: true
  delegate :status, to: :contact

  after_create :_create_contact
  after_destroy :_comfirm_customer_exist

  def manager?(current_user_id)
    user_id == current_user_id
  end

  private

  def attributes
    {
      'id'            => nil,
      'customer_id'   => nil,
      'customer_name' => nil,
      'schedule_id'   => nil,
      'date'          => nil,
      'time'          => nil,
      'count'         => nil,
      'contact_id'    => nil,
      'status'        => nil,
    }
  end

  def _comfirm_customer_exist
    customer.destroy! if customer.tickets.blank?
  end

  def _create_contact
    create_contact(user_id: customer.user.id)
  end
end
