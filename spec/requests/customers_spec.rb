# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  before do
    user = create(:user)
    sign_in user
  end

  let(:customer) { create(:customer) }

  describe "GET #index" do
    before { get "/customers" }

    it { expect(response).to have_http_status(200) }
  end

  describe "PUT #update" do
    context "変更する名前が既に登録されている場合" do
      before do
        create(:customer, name: "テスト 花子")
        put "/customers/#{customer.id}", params: { customer: { name: "テスト 花子" } }
      end

      it { expect(response).to have_http_status(422) }
    end

    context "変更する名前が登録されていない場合" do
      before do
        put "/customers/#{customer.id}", params: { customer: { name: "テスト 花子" } }
      end

      it { expect(response).to have_http_status(204) }
    end

    context "変更する名前が入力されていない場合" do
      before do
        put "/customers/#{customer.id}", params: { customer: { name: "" } }
      end

      it { expect(response).to have_http_status(422) }
    end
  end
end
