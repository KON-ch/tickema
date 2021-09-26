# frozen_string_literal: true

require "rails_helper"

RSpec.describe Stage, type: :model do
  before do
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
    FactoryBot.create(:stage_schedule)
  end

  let(:stage) { Stage.first }

  describe "Stageモデルのバリデーションテスト" do
    subject { Stage.new(title: title) }

    context "タイトルが入力されている場合" do
      let(:title) { "テストタイトル" }

      it "正常に登録されること" do
        is_expected.to be_valid
      end
    end

    context "タイトルが入力されていない場合" do
      let(:title) { nil }

      it "登録されないこと" do
        is_expected.not_to be_valid
      end
    end

    context "タイトルが20文字を超える場合" do
      let(:title) { "20文字を超える長いタイトルは登録することができない" }

      it "登録されないこと" do
        is_expected.not_to be_valid
      end
    end
  end

  describe "set_schedules" do
    it "日程情報が取得できること" do
      expect(stage.set_schedules).to eq ([
        {
          id:           1,
          staging_date: "12月31日",
          start_time:   "13:30"
        }
      ])
    end
  end
end
