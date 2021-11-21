# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "serializable_hash" do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
      FactoryBot.create(:customer)
    end

    let(:ticket) { FactoryBot.create(:ticket) }

    subject { ticket.serializable_hash }

    it "設定された情報がhashで取得できること" do
      expect(subject).to eq(
        {
          "contact_id"    => ticket.contact.id,
          "count"         => 2,
          "customer_id"   => 1,
          "customer_name" => "テスト 太郎",
          "date"          => "12月31日(木)",
          "id"            => 1,
          "schedule_id"   => 1,
          "status"        => "reserved",
          "time"          => "13:30"
        }
      )
    end
  end
end
