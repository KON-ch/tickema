# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    id { 1 }
    name { "テスト 太郎" }
    user_id { 1 }
  end
end
