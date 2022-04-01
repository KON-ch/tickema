class Customer < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :customer_stage_histories , dependent: :destroy
  has_many :stages, through: :customer_stage_histories
  belongs_to :user

  validates :name, presence: true, length: { maximum: 10 }
end
