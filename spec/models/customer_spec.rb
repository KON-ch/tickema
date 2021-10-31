require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:stage)
    FactoryBot.create(:customer)
    FactoryBot.create(:schedule)
    FactoryBot.create(:stage_schedule)
    FactoryBot.create(:stage_customer)
  end

    let(:stage) { Stage.first }
    let(:customer) { Customer.first }

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

  describe "stage_ids" do
    it "今までに観たStageのIDが取得できること" do
      expect(customer.stage_ids).to eq ([1])
    end
  end

  describe "watch?" do
    subject { customer.watch?(stage_id) }

    context "観たことのあるStageの場合" do
      let(:stage_id) { 1 }

      it { expect(subject).to eq true }
    end

    context "観たことのないStageの場合" do
      let(:stage_id) { 999 }

      it { expect(subject).to eq false }
    end
  end

end
