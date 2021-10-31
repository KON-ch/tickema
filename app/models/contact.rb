class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  enum status: { reserved: 0, applied: 1, notified: 2, finished: 3 }
end
