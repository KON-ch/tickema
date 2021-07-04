# frozen_string_literal: true

require "rails_helper"

RSpec.describe Stage, type: :model do
  describe "Stageモデルのバリデーションテスト" do
    it "正常に登録されること" do
      stage = FactoryBot.build(:stage)
      expect(stage).to be_valid
    end

    context "タイトルが入力されていない場合" do
      it "登録されないこと" do
        stage = FactoryBot.build(:stage, title: "")
        expect(stage).not_to be_valid
      end
    end

    context "タイトルが20文字を超える場合" do
      it "登録されないこと" do
        stage = FactoryBot.build(:stage, title: "20文字を超える長いタイトルは登録することができない")
        expect(stage).not_to be_valid
      end
    end
  end
end
