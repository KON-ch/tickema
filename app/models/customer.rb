class Customer < ApplicationRecord
  has_many :stage_customers, dependent: :destroy
  has_many :stage_schedules, through: :stage_customers
  belongs_to :user

  validates :name, presence: true, length: { maximum: 10 }

  after_save :create_stage_customer

  attr_accessor :schedule_id

  def set_customer_data(customers_data, stage_id:)
    stage_schedules.each do |s|
      next unless s.stage_id == stage_id.to_i

      stage_customer = s.stage_customers.find_by(customer_id: id)

      customers_data << {
        id:          id,
        name:        name,
        schedule_id: s.id,
        date:        s.schedule.staging_date.strftime("%m月%d日"),
        count:       stage_customer.count,
        contacted:   stage_customer.contacted
      }
    end

    customers_data
  end

  private

  def create_stage_customer
    stage_customers.create(customer_id: id, stage_schedule_id: schedule_id)
  end
end
