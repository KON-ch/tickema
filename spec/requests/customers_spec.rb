require 'rails_helper'

RSpec.describe "Customers", type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
  end

  let(:schedule_id) { FactoryBot.create(:stage_schedule).id }
  let(:customer) { FactoryBot.create(:customer) }

  describe "GET #index " do
    it "status 200" do
      get "/customers"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "名前を取得できること" do
      get "/customers/#{customer.id}"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json["name"]).to eq(customer.name)
    end
  end

  describe "POST #create" do
    before { post "/customers", params: { customer: name, schedule: { id: schedule_id } } }

    context "名前が入力されている場合" do
      let(:name) { { family_name: "テスト", first_name: "花子" } }

      it "登録できること" do
        expect(response).to have_http_status(201)
      end
    end

    context "名前が入力されていない場合" do
      let(:name) { { family_name: nil, first_name: nil } }

      it "登録できないこと" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT #update" do
    before { put "/customers/#{customer.id}", params: { customer: name } }

    context "名前が入力されている場合" do
      let(:name) { { family_name: "テスト", first_name: "花子" } }

      it "更新できること" do
        expect(response).to have_http_status(204)
      end
    end

    context "名前が入力されていない場合" do
      let(:name) { { family_name: nil, first_name: nil } }

      it "更新されないこと" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "顧客情報が削除されること" do
      delete "/customers/#{customer.id}"
      expect(response).to have_http_status(204)
    end
  end

  describe "PUT #data" do
    before do
      FactoryBot.create(:stage_customer, stage_schedule_id: schedule_id, customer_id: customer.id)
      put "/customers/#{customer.id}/data", params: { customer: { count: count, contacted: contacted }, schedule: { id: schedule_id } }
    end

    context "購入枚数が増える場合" do
      let(:count) { StageCustomer.first.count + 1 }
      let(:contacted) { false }

      it "購入枚数が+1されること" do
        expect(response).to have_http_status(204)
        expect(StageCustomer.first.count).to eq count
      end
    end

    context "購入枚数が減る場合" do
      let(:count) { StageCustomer.first.count - 1 }
      let(:contacted) { false }

      it "購入枚数が-1されること" do
        expect(response).to have_http_status(204)
        expect(count).to eq count
      end
    end

    context "連絡済みの場合" do
      let(:contacted) { true }
      let(:count) { 1 }

      it { expect(StageCustomer.first.contacted).to eq true }
    end

    context "連絡済みではない場合" do
      let(:contacted) { false }
      let(:count) { 1 }

      it { expect(StageCustomer.first.contacted).to eq false }
    end
  end
end
