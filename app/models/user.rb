class User < ApplicationRecord
  # :confirmable(登録時のメール認証), :trackable, :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :timeoutable # 自動ログアウト

  has_many :customers, dependent: :destroy

  def set_customers(stage_id:)
    customers_data = []

    customers_data.tap {
      customers.each do |customer|
        customer.stage_customers.eager_load(:stage_schedule).each do |stage_customer|
          next unless stage_customer.stage_schedule.stage_id == stage_id

          customers_data << {
            id:          customer.id,
            name:        customer.name,
            schedule_id: stage_customer.stage_schedule.id,
            date:        stage_customer.stage_schedule.schedule.staging_date.strftime("%m月%d日"),
            count:       stage_customer.count,
            contacted:   stage_customer.contacted
          }
        end
      end
    }
  end
end
