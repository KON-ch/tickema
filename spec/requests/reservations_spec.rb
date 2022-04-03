require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  include_context "user is logged in"

  let(:reservation) { create(:reservation) }

  describe "POST#create" do
    context "顧客名が入力されていない場合" do
      before do
        post "/reservations", params: { customer: { name: nil } }
      end

      it { expect(response).to have_http_status(422) }
    end

    context "予約する顧客が同日に予約済みの場合" do
      before do
        post "/reservations",
          params: {
            customer: { name: "テスト 太郎" },
            reservation: { schedule_id: reservation.schedule_id }
          }
      end

      it { expect(response).to have_http_status(422) }
    end

    context "予約する日に登録されていない顧客の場合" do
      before do
        post "/reservations",
          params: {
            customer: { name: "テスト 花子" },
            reservation: { schedule_id: reservation.schedule_id }
          }
      end

      it { expect(response).to have_http_status(201) }
    end
  end

  describe "DELETE#destroy" do
    before do
      delete "/reservations/#{reservation.id}"
    end

    it { expect(response).to have_http_status(204) }
  end

  describe "PATCH#status" do
    context "更新するステータスが有効な場合" do
      before do
        patch "/reservations/#{reservation.id}/status",
          params: { reservation: { status: "applied" } }
      end

      it { expect(response).to have_http_status(200) }
    end

    context "更新するステータスが無効な場合" do
      before do
        patch "/reservations/#{reservation.id}/status",
          params: { reservation: { status: "foobar" } }
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe "PATCH#count" do
    context "更新する枚数が有効な場合" do
      before do
        patch "/reservations/#{reservation.id}/count",
          params: { reservation: { count: 2 } }
      end

      it { expect(response).to have_http_status(204) }
    end

    context "更新する枚数が無効な場合" do
      before do
        patch "/reservations/#{reservation.id}/count",
          params: { reservation: { count: 0 } }
      end

      it { expect(response).to have_http_status(422) }
    end
  end
end
