class Customer < ApplicationRecord
  has_many :tickets, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 10 }

  def have_ticket?(stage_id)
    tickets.where(stage_id: stage_id).present?
  end
end
