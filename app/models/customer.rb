class Customer < ApplicationRecord
  has_many :tickets, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 10 }
end
