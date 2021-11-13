# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  shared_examples "Not recorded" do
    it "登録されないこと" do
      expect(response).to have_http_status(422)
    end
  end

  before do
    user = FactoryBot.create(:user)
    sign_in user
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
    FactoryBot.create(:customer)
  end

  describe "POST #create" do
    before do
      post "/tickets", params:
        {
          ticket: {
            count:       count,
            stage_id:    1,
            schedule_id: 1,
            customer_id: 1
          }
        }
    end

    context "購入枚数が設定されている場合" do
      let(:count) { 1 }

      it "作成したチケットの情報が作成されること" do
        expect(response).to have_http_status(201)
      end
    end

    context "購入枚数が設定されていない場合" do
      let(:count) { nil }

      it_behaves_like "Not recorded"
    end
  end

  describe "PUT #update" do
    before do
      FactoryBot.create(:ticket)

      put "/tickets/1", params:
        {
          ticket: {
            count:       count,
            stage_id:    1,
            schedule_id: 1,
            customer_id: 1
          }
        }
    end

    context "購入枚数が設定されている場合" do
      let(:count) { 3 }

      it "チケットの枚数が更新されること" do
        expect(response).to have_http_status(204)
      end
    end

    context "枚数が設定されていない場合" do
      let(:count) { nil }

      it_behaves_like "Not recorded"
    end
  end

  describe "DELEATE #destroy" do
    before do
      FactoryBot.create(:ticket)
      delete "/tickets/1"
    end

    it "削除されること" do
      expect(response).to have_http_status(204)
    end
  end
end
