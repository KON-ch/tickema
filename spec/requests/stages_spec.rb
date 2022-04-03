# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Stages", type: :request do
  describe "GET #show" do
    let(:stage) { create(:stage) }

    context "ログインしている場合" do
      include_context "user is logged in"

      before { get "/stages/#{stage.id}" }

      it { expect(response).to have_http_status(200) }
    end

    it_behaves_like "not logged in user is redirect" do
      before { get "/stages/#{stage.id}" }
    end
  end
end
