require 'rails_helper'

RSpec.describe StageCustomer, type: :model do
  describe "StageCustomerモデルのバリデーションテスト" do
    before do
      FactoryBot.create(:customer)
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
      FactoryBot.create(:stage_schedule)
    end

    it "正常に登録されること" do
      stage_customer = FactoryBot.build(:stage_customer)
      expect(stage_customer).to be_valid
    end

    context "stage_schedule_idが入力されていない場合" do
      it "登録されないこと" do
        stage_customer = FactoryBot.build(:stage_customer, stage_schedule_id: nil)
        expect(stage_customer).not_to be_valid
      end
    end

    context "customer_idが入力されていない場合" do
      it "登録されないこと" do
        stage_customer = FactoryBot.build(:stage_customer, customer_id: nil)
        expect(stage_customer).not_to be_valid
      end
    end
  end
end
