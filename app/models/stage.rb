class Stage < ApplicationRecord
  has_many :schedules, -> { order(%i[staged_on staged_at]) }

  has_many :user_stages, dependent: :destroy
  has_many :users, through: :user_stages

  has_many :tickets, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
end
