# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    id { 1 }
    staged_at { Time.new(2020, 10, 10, 13, 30, 0, "+09:00") }
    staged_on { Date.new(2020, 12, 31) }
  end
end
