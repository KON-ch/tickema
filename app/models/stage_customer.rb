class StageCustomer < ApplicationRecord
  belongs_to :stage_schedule
  belongs_to :customer

  validates :stage_schedule_id, presence: true
  validates :customer_id, presence: true
end
