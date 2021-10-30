class Ticket < ApplicationRecord
  belongs_to :stage
  belongs_to :schedule
  belongs_to :customer
end
