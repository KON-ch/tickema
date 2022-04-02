class Stage < ApplicationRecord
  has_many :schedules, -> { order(%i[staged_on staged_at]) }, dependent: :destroy
  belongs_to :user

  has_many :customer_stage_histories , dependent: :destroy
  has_many :customers, through: :customer_stage_histories

  validates :title, presence: true, length: { maximum: 20 }
end
