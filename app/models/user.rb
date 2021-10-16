class User < ApplicationRecord
  # :confirmable(登録時のメール認証), :trackable, :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable # 自動ログアウト

  has_many :customers, dependent: :destroy

  def set_customers(stage_id)
    customers.map { |customer| customer.data(stage_id) }.flatten
  end
end
