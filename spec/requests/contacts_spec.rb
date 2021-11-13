# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsController, type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
    FactoryBot.create(:customer)
    FactoryBot.create(:ticket)
    FactoryBot.create(:contact)
  end

  describe "PUT #update" do
    before do
      put "/contacts/1", params: { contact: { status: status, ticket_id: 1 } }
    end

    context "statusに正しい値が設定されている場合" do
      let(:status) { "finished" }

      it "更新されること" do
        expect(response).to have_http_status(201)
      end
    end

    context "statusに不正な値が設定されている場合" do
      let(:status) { "happy" }

      it "更新されないこと" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
