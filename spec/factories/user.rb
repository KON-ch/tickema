# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "ใในใ" }
    email { "test@example.com" }
    password { 123456789012 }

    trait :sample_user do
      email { ENV["TEST_USER_EMAIL"] }
    end
  end
end
