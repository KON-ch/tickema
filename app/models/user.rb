class User < ApplicationRecord
  # :confirmable(登録時のメール認証), :trackable, :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable # 自動ログアウト

  has_many :customers, dependent: :destroy
  has_many :contact, dependent: :destroy

  has_many :user_stages, dependent: :destroy
  has_many :stages, through: :user_stages
end
