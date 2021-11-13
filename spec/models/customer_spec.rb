# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:stage)
    FactoryBot.create(:customer)
    FactoryBot.create(:schedule)
    FactoryBot.create(:ticket)
  end

    let(:stage) { Stage.first }
    let(:customer) { Customer.first }

  describe "validates" do
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
end
