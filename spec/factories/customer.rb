# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { "テスト 太郎" }
    user { User.find_by(email: "test@example.com" ) }
  end
end
