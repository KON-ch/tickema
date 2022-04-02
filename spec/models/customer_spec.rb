# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  before { create(:user) }

  let(:customer) { create(:customer) }

  describe "confirm_reservation" do
    subject { Customer.find_by(id: customer.id) }

    before { customer.confirm_reservation }

    context "予約がない場合" do
      it "顧客が削除されること" do
        expect(subject).to be_falsey
      end
    end

    context "予約がある場合" do
      before { create(:reservation) }

      it "顧客が登録されていること" do
        expect(subject).to eq nil
      end
    end
  end

  describe "validates" do
    it "正常に登録されること" do
      customer = build(:customer)
      expect(customer).to be_valid
    end

    context "名前が入力されていない場合" do
      it "登録されないこと" do
        customer = build(:customer, name: nil)
        expect(customer).not_to be_valid
      end
    end

    context "名前が10文字以上の場合" do
      it "登録されないこと" do
        customer = build(:customer, name: "テストです 名前が長すぎる")
        expect(customer).not_to be_valid
      end
    end
  end
end
