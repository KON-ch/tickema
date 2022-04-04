# frozen_string_literal: true

FactoryBot.define do
  factory :stage do
    title { "ステージテストタイトル" }
    user { User.find_by(email: attributes_for(:user)[:email] ) }

    trait :stage_2 do
      title { "テスト作品2" }
    end

    trait :stage_for_sample_user do
      user { User.find_by(email: attributes_for(:user, :sample_user)[:email] ) }
    end
  end
end
