# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "テスト" }
    email { "test@example.com" }
    password { 123456789012 }
  end
end
