class Customer < ApplicationRecord
  has_many :stage_customers, dependent: :destroy
  has_many :stages, through: :stage_customers

  validates :name, presence: true, length: { maximum: 10 }

  after_save :create_stage_customer

  def set_schedule_id(schedule_id)
    @schedule_id = schedule_id
  end

  private
    def create_stage_customer
      self.stage_customers.create(customer_id: id, stage_schedule_id: @schedule_id)
    end
end
