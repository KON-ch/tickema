require 'rails_helper'

RSpec.describe Customer, type: :model do
  before { FactoryBot.create(:user) }

  describe "Customerモデルのバリデーションテスト" do
    it "正常に登録されること" do
      customer = FactoryBot.build(:customer)
      expect(customer).to be_valid
    end

    context "名前が入力されていない場合" do
      it "登録されないこと" do
        customer = FactoryBot.build(:customer, name: nil)
        expect(customer).not_to be_valid
      end
    end

    context "名前が10文字以上の場合" do
      it "登録されないこと" do
        customer = FactoryBot.build(:customer, name: "テストです 名前が長すぎる")
        expect(customer).not_to be_valid
      end
    end
  end

  describe "set_customer_data" do
    before do
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
      FactoryBot.create(:stage_schedule)
      FactoryBot.create(:customer)
      FactoryBot.create(:stage_customer)
    end

    let(:customer) { Customer.first }

    it "顧客情報が取得できること" do
      expect(customer.set_customer_data([], stage_id: 1)).to eq ([
        {
          id:          1,
          name:        "テスト 太郎",
          schedule_id: 1,
          date:        "12月31日",
          count:       2,
          contacted:   false,
        }
      ])
    end
  end
end
