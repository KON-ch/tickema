class Schedule < ApplicationRecord
  validates :start_time, presence: true
  validates :staging_date, presence: true
end
