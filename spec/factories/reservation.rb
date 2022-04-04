# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    association :schedule
    association :customer

    trait :for_sample_user do
      association :schedule, :schedule_for_sample_user
      association :customer, :customer_for_sample_user
    end
  end
end
