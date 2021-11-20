class Contact < ApplicationRecord
  STATUS = { reserved: 0, applied: 1, notified: 2, finished: 3 }

  belongs_to :user
  belongs_to :ticket

  enum status: STATUS

  validates :status, presence: true
end
