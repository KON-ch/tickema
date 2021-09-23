# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    id { 1 }
    start_time { "13:30" }
    staging_date { "2021/12/31" }
  end
end
