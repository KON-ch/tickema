# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    id { 1 }
    stage_id { 1 }
    schedule_id { 1 }
    customer_id { 1 }
    count { 2 }
  end
end
