class Schedule < ApplicationRecord
  belongs_to :stage
  has_many :tickets, dependent: :nullify

  validates :staged_at, presence: true
  validates :staged_on, presence: true


  def staged_on
    # "4月1日"
    I18n.l(super) if super
  end

  def staged_at
    # "13:30"
    I18n.l(super) if super
  end
end
