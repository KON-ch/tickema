class Customer < ApplicationRecord
  has_many :stage_customers, dependent: :destroy
  has_many :stages, through: :stage_customers
  belongs_to :user

  validates :name, presence: true, length: { maximum: 10 }

  after_save :create_stage_customer
  attr_accessor :schedule_id

  private
    def create_stage_customer
      stage_customers.create(customer_id: id, stage_schedule_id: schedule_id)
    end
end
