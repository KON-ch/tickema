# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
    FactoryBot.create(:customer)
    FactoryBot.create(:ticket)
  end

  describe "POST #create" do
    before do
      post "/customers", params: {
        customer: name,
        ticket: {
          stage_id: 1,
          schedule_id: 1
        }
      }
    end

    context "名前が入力されている場合" do
      let(:name) { { name: "テスト 花子" } }

      it "登録できること" do
        expect(response).to have_http_status(201)
      end
    end

    context "名前が入力されていない場合" do
      let(:name) { { name: nil } }

      it "登録できないこと" do
        expect(response).to have_http_status(422)
      end
    end

    context "既に登録されている場合" do
      let(:name) { { name: "テスト 太郎" } }

      it "登録できないこと" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
