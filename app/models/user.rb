class User < ApplicationRecord
  # :confirmable(登録時のメール認証), :trackable, :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable # 自動ログアウト
end
