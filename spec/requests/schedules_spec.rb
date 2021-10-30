require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "POST #create" do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      post "/schedules", params: { schedule: schedule, stage: { id: stage_id } }
    end

    let(:stage) { FactoryBot.create(:stage) }

    context "全ての値が正しく入力されている場合" do
      let(:stage_id) { stage.id }
      let(:schedule) { [{ staged_on: "2021/12/31", staged_at: "14:00" }] }

      it "登録できること" do
        expect(response).to have_http_status(201)
      end
    end

    context "公演IDが存在しない場合" do
      let(:stage_id) { 999999 }
      let(:schedule) { [{ staged_on: "2021/12/31", staged_at: "14:00" }] }

      it "登録できないこと" do
        expect(response).to have_http_status(422)
      end
    end

    context "日時が入力されていない場合" do
      let(:stage_id) { stage.id }
      let(:schedule) { [{ staged_on: nil, staged_at: nil }] }

      it "登録できないこと" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
