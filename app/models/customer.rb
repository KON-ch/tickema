class Customer < ApplicationRecord
  has_many :stage_customers, dependent: :destroy
  has_many :stage_schedules, through: :stage_customers
  has_many :tickets, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 10 }

  after_save :create_stage_customer

  attr_accessor :schedule_id

  def data(stage_id)
    stage_schedules.where(stage_id: stage_id).map do |stage_schedule|
      stage_customer = stage_customers.find_by(stage_schedule_id: stage_schedule.id)
      {
        id:          id,
        name:        name,
        schedule_id: stage_schedule.id,
        date:        stage_schedule.staging_date,
        time:        stage_schedule.start_time,
        count:       stage_customer.count,
        contacted:   stage_customer.contacted,
      }
    end
  end

  def stage_ids
    stage_schedules.map(&:stage_id).uniq
  end

  def watch?(stage_id)
    stage_ids.include?(stage_id)
  end

  private

  def create_stage_customer
    stage_customers.create(customer_id: id, stage_schedule_id: schedule_id)
  end
end
