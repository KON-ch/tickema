# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { "テスト 太郎" }
    user { User.find_by(email: attributes_for(:user)[:email]) }

    trait :customer_2 do
      name { "テスト 花子" }
    end

    trait :customer_for_sample_user do
      user { User.find_by(email: attributes_for(:user, :sample_user)[:email]) }
    end
  end
end
