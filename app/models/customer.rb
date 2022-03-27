class Customer < ApplicationRecord
  has_many :tickets, dependent: :destroy
  belongs_to :user

  delegate :stage_ids, to: :tickets

  scope :not_reserved,
    -> (stage_id) { select { |cuctomer| cuctomer.stage_ids.exclude?(stage_id.to_i) } }

  validates :name, presence: true, length: { maximum: 10 }
end
