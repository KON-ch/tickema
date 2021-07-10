require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "POST #create" do
    context "登録できる場合" do
      it "status 201" do
        post "/schedules", params: { schedule: FactoryBot.attributes_for(:schedule) }
        expect(response).to have_http_status(201)
      end
    end

    context "登録できない場合" do
      it "status 422" do
        post "/schedules", params: { schedule: FactoryBot.attributes_for(:schedule, start_time: nil)}
        expect(response).to have_http_status(422)
      end
    end
  end
end
