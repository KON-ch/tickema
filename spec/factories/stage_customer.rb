# frozen_string_literal: true

FactoryBot.define do
  factory :stage_customer do
    id { 1 }
    stage_schedule_id { 1 }
    customer_id { 1 }
  end
end
