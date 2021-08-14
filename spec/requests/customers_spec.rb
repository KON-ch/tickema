require 'rails_helper'

RSpec.describe "Customers", type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
  end

  describe "GET #index " do
    it "status 200" do
      get "/customers"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "公演タイトルを取得できること" do
      customer = FactoryBot.create(:customer)
      get "/customers/#{customer.id}"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json["name"]).to eq(customer.name)
    end
  end

  describe "POST #create" do
    before do
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
    end

    let(:schedule_id) { FactoryBot.create(:stage_schedule).id }

    context "登録できる場合" do
      it "status 201" do
        post "/customers", params: { customer: FactoryBot.attributes_for(:customer, family_name: "テスト", first_name: "太郎",), schedule: { id: schedule_id } }

        expect(response).to have_http_status(201)
      end
    end

    context "登録できない場合" do
      it "status 422" do
        post "/customers", params: { customer: FactoryBot.attributes_for(:customer, family_name: nil, first_name: nil), schedule: { id: schedule_id } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT #update" do
    let(:customer) { FactoryBot.create(:customer) }

    context "更新できる場合" do
      it "status 204" do
        put "/customers/#{customer.id}", params: { customer: { family_name: "テスト", first_name: "新太郎" } }
        expect(response).to have_http_status(204)
      end
    end

    context "更新できない場合" do
      it "status 422" do
        put "/customers/#{customer.id}", params: { customer: { family_name: nil, first_name: nil } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "公演情報が削除されること" do
      customer = FactoryBot.create(:customer)
      delete "/customers/#{customer.id}"
      expect(response).to have_http_status(204)
    end
  end

  describe "PUT #count" do
    before do
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
    end

    let(:schedule_id) { FactoryBot.create(:stage_schedule).id }
    let(:customer) { FactoryBot.create(:customer) }
    let(:count) { FactoryBot.create(:stage_customer).count }

    context "購入枚数が増える場合" do
      it "購入枚数が+1されること" do
        put "/customers/#{customer.id}/count", params: { customer: { schedule_id: schedule_id, count: count + 1 } }
        expect(response).to have_http_status(204)
        expect(StageCustomer.first.count).to eq count + 1
      end
    end

    context "購入枚数が減る場合" do
      it "購入枚数が-1されること" do
        put "/customers/#{customer.id}/count", params: { customer: { schedule_id: schedule_id, count: count - 1 } }
        expect(response).to have_http_status(204)
        expect(StageCustomer.first.count).to eq count - 1
      end
    end

    context "購入枚数が0になる場合" do
      it "更新されないこと" do
        put "/customers/#{customer.id}/count", params: { customer: { schedule_id: schedule_id, count: 0 } }
        expect(response).to have_http_status(422)
      end
    end
  end
end
