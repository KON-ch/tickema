# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Stages", type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
    FactoryBot.create(:customer)
    FactoryBot.create(:ticket)
  end

  let(:contact) { Contact.first }

  describe "GET #show" do
    it "公演情報を取得できること" do
      get "/stages/1"
      json = JSON.parse(response.body)
      expect(json).to eq(
        {
          "id" => 1,
          "title" => "ステージテストタイトル",
          "stages" => [],
          "schedules" => [
            {
              "id" => 1,
              "staged_at" => "13:30",
              "staged_on" => "12月31日(木)"
            }
          ],
          "tickets" => [
            {
              "id" => 1,
              "customer_id" => 1,
              "customer_name" => "テスト 太郎",
              "schedule_id" => 1,
              "date" => "12月31日(木)",
              "time" => "13:30",
              "count" => 2,
              "contact_id" => contact.id,
              "status" => contact.status
            }
          ],
          "unbooked_customers" => []
        }
      )
    end
  end
end
