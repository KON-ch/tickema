require 'rails_helper'

RSpec.describe "StageSchedules", type: :request do
  describe "GET #show" do
    it "公演日程から顧客情報が取得できること" do
      user = FactoryBot.create(:user)
      sign_in user

      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
      stage_schedule = FactoryBot.create(:stage_schedule)
      customer = FactoryBot.create(:customer)
      FactoryBot.create(:stage_customer)

      get "/stage_schedules/#{stage_schedule.id}"
      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json[0]["name"]).to eq(customer.name)
    end
  end
end
