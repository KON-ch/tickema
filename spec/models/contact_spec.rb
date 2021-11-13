# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:stage)
    FactoryBot.create(:customer)
    FactoryBot.create(:schedule)
    FactoryBot.create(:ticket)
  end

  describe "validates" do
    let(:contact) { FactoryBot.build(:contact, status: status) }

    context "ステータスが正常な数字の場合" do
      let(:status) { 1 }

      it "正常に登録されること" do
        expect(contact).to be_valid
      end
    end

    context "ステータスが正常な値の場合" do
      let(:status) { "reserved" }

      it "正常に登録されること" do
        expect(contact).to be_valid
      end
    end

    context "ステータスが入力されていない場合" do
      let(:status) { nil }

      it "登録されないこと" do
        expect(contact).not_to be_valid
      end
    end
  end
end
