require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
    FactoryBot.create(:stage_schedule)
    FactoryBot.create(:customer)
    FactoryBot.create(:stage_customer)
  end

  let(:stage) { Stage.first }
  let(:user) { User.first }

  describe "set_customers" do
    it "顧客情報が取得できること" do
      expect(user.set_customers(stage.id)).to eq (
        [
          {
            id:          1,
            name:        "テスト 太郎",
            schedule_id: 1,
            date:        "12月31日",
            time:        "13:30",
            count:       2,
            contacted:   false,
          }
        ]
      )
    end
  end
end
