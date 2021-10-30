# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    id { 1 }
    staged_at { "13:30" }
    staged_on { "2021/12/31" }
  end
end
