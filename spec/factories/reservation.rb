# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    association :schedule
    association :customer
  end
end
