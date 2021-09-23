require "rails_helper"

RSpec.describe "Stages", type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
  end

  let(:stage) { FactoryBot.create(:stage) }

  describe "GET #index " do
    it "status 200" do
      get "/stages"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "公演タイトルを取得できること" do
      get "/stages/#{stage.id}"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json["title"]).to eq(stage.title)
    end
  end

  describe "POST #create" do
    before do
      post "/stages", params: { stage: { title: title} }
    end

    context "タイトルが入力されている場合" do
      let(:title ) { "テスト題名" }

      it "登録できること" do
        expect(response).to have_http_status(201)
      end
    end

    context "タイトルが入力されていない場合" do
      let(:title ) { nil }

      it "登録できないこと" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT #update" do
    before do
      put "/stages/#{stage.id}", params: { stage: { title: title } }
    end

    context "タイトルが入力されている場合" do
      let(:title) { "新テストタイトル" }

      it "更新されること" do
        expect(response).to have_http_status(204)
      end
    end

    context "タイトルが入力されていない場合" do
      let(:title) { nil }

      it "status 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "公演情報が削除されること" do
      delete "/stages/#{stage.id}"
      expect(response).to have_http_status(204)
    end
  end
end
