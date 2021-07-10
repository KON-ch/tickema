require "rails_helper"

RSpec.describe "Stages", type: :request do
  describe "GET #index " do
    it "status 200" do
      get "/stages"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "公演タイトルを取得できること" do
      stage = FactoryBot.create(:stage)
      get "/stages/#{stage.id}"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json["title"]).to eq(stage.title)
    end
  end

  describe "POST #create" do
    context "登録できる場合" do
      it "status 201" do
        post "/stages", params: { stage: FactoryBot.attributes_for(:stage) }
        expect(response).to have_http_status(201)
      end
    end

    context "登録できない場合" do
      it "status 422" do
        post "/stages", params: { stage: FactoryBot.attributes_for(:stage, title: nil)}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT #update" do
    before do
      @stage = FactoryBot.create(:stage)
    end

    context "更新できる場合" do
      it "status 204" do
        put "/stages/#{@stage.id}", params: { stage: { title: "ステージニューテストタイトル" } }
        expect(response).to have_http_status(204)
      end
    end

    context "更新できない場合" do
      it "status 422" do
        put "/stages/#{@stage.id}", params: { stage: { title: nil } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "公演情報が削除されること" do
      stage = FactoryBot.create(:stage)
      delete "/stages/#{stage.id}"
      expect(response).to have_http_status(204)
    end
  end
end
