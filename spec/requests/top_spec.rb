# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET #index " do
    context "ログインしている場合" do
      include_context "user is logged in"

      before { get "/" }

      it { expect(response).to have_http_status(200) }
    end

    context "ログインしていない場合" do
      before { get "/" }

      it "ログイン画面へリダイレクトすること" do
        expect(response).to have_http_status(302)
      end
    end
  end
end
