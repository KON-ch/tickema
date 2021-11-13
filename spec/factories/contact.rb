# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    id { 1 }
    status { 0 }
    user_id { 1 }
    ticket_id { 1 }
  end
end
