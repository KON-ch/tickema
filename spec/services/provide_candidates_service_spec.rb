# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProvideCandidatesService, type: :service do
  subject { described_class.new(user_id: user.id, stage_id: stage_id).list }

  let(:user) { create(:user) }
  let(:stage_1) { build(:stage) }
  let(:stage_2) { build(:stage, :stage_2) }

  before do
    # stage_2を予約していない顧客
    @customer_1 = create(:customer, user: user) do |customer|
      create(:customer_stage_history, customer: customer, stage: stage_1)
    end

    # stage_1を予約していない顧客
    @customer_2 = create(:customer, :customer_2, user: user) do |customer_2|
      create(:customer_stage_history, customer: customer_2, stage: stage_2)
    end

    # stage_1とstage_2を予約した顧客
    create(:customer, name: "テスト 次郎", user: user) do |customer_3|
      create(:customer_stage_history, customer: customer_3, stage: stage_1)
      create(:customer_stage_history, customer: customer_3, stage: stage_2)
    end
  end

  context "stage_1を指定した場合" do
    let(:stage_id) { stage_1.id }

    it { is_expected.to eq([@customer_2]) }
  end

  context "stage_2を指定した場合" do
    let(:stage_id) { stage_2.id }

    it { is_expected.to eq([@customer_1]) }
  end
end
