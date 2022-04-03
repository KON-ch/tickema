# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  let(:customer) { create(:customer) }

  describe "GET #index" do
    it_behaves_like "not logged in user is redirect" do
      before { get "/customers" }
    end

    context "ログインしている場合" do
      include_context "user is logged in"

      before { get "/customers" }

      it { expect(response).to have_http_status(200) }
    end
  end

  describe "PUT #update" do
    it_behaves_like "not logged in user is redirect" do
      before { put "/customers/#{customer.id}" }
    end

    context "ログインしている場合" do
      include_context "user is logged in"

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
end
