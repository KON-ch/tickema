require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    it "status 200" do
      user = FactoryBot.create(:user)
      sign_in user

      stage = FactoryBot.create(:stage)
      stage = [{ "id"=> stage.id, "title"=> stage.title }]

      get "/mypage"
      json = JSON.parse(response.body)
      expect(json).to eq(stage)
      expect(response).to have_http_status(200)
    end
  end

end
