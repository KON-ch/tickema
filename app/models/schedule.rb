class Schedule < ApplicationRecord
  belongs_to :stage
  has_many :tickets, dependent: :nullify

  validates :staged_at, presence: true
  validates :staged_on, presence: true


  def staged_on
    super&.strftime("%m月%d日")
  end

  def staged_at
    super&.strftime("%H:%M")
  end
end
