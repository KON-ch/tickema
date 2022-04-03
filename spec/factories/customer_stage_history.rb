# frozen_string_literal: true

FactoryBot.define do
  factory :customer_stage_history do
    stage
    customer
  end
end
