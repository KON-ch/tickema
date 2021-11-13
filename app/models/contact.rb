class Contact < ApplicationRecord
  STATUSES = { reserved: 0, applied: 1, notified: 2, finished: 3 }.freeze
  private_constant :STATUSES

  belongs_to :user
  belongs_to :ticket

  enum status: STATUSES

  validates :status, presence: true
end
