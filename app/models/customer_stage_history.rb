class CustomerStageHistory < ApplicationRecord
  belongs_to :customer
  belongs_to :stage
end
