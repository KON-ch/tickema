# frozen_string_literal: true

FactoryBot.define do
  factory :stage do
    title { "ステージテストタイトル" }
    user { User.find_by(email: "test@example.com" ) }
  end
end
