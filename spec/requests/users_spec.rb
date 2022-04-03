# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /mypage" do
    it_behaves_like "not logged in user is redirect" do
      before { get "/mypage" }
    end

    context "ログインしている場合" do
      include_context "user is logged in"

      before { get "/mypage" }

      it { expect(response).to have_http_status(200) }
    end
  end

end
