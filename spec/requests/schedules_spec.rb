require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "POST #create" do
    before do
      @stage = FactoryBot.create(:stage)
    end

    context "登録できる場合" do
      it "status 201" do
        post "/schedules", params: { schedule: FactoryBot.attributes_for(:schedule), stage_id: @stage.id }
        expect(response).to have_http_status(201)
      end
    end

    context "公演IDが存在しない場合" do
      it "status 204" do
        post "/schedules", params: { schedule: FactoryBot.attributes_for(:schedule), stage_id: @stage.id + 1 }
        expect(response).to have_http_status(204)
      end
    end

    context "登録できない場合" do
      it "status 422" do
        post "/schedules", params: { schedule: FactoryBot.attributes_for(:schedule, start_time: nil), stage_id: @stage.id }
        expect(response).to have_http_status(422)
      end
    end
  end
end
