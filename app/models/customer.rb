class Customer < ApplicationRecord
  has_many :stage_customers, dependent: :destroy
  has_many :stages, through: :stage_customers

  validates :name, presence: true, length: { maximum: 10 }
end
