# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "validates" do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
      FactoryBot.create(:customer)
    end

    let(:ticket) { FactoryBot.create(:ticket) }
    let(:contact) { ticket.contact }

    describe "manager?" do
      subject { ticket.manager?(user)}

      context "チケットの持ち主が自分の顧客の場合" do
        let(:user) { User.first }

        it { is_expected.to eq true }
      end

      context "チケットの持ち主が自分の顧客ではない場合" do
        let(:user) { FactoryBot.build(:user, id: 2) }

        it { is_expected.to eq false }
      end
    end
  end
end
