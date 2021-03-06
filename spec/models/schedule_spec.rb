# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before { create(:user) }

  describe "validates" do
    it "正常に登録されること" do
      schedule = build(:schedule)
      expect(schedule).to be_valid
    end

    context "開演時間が入力されていない場合" do
      it "登録されないこと" do
        schedule = build(:schedule, staged_at: nil)
        expect(schedule).not_to be_valid
      end
    end

    context "公演日が入力されていない場合" do
      it "登録されないこと" do
        schedule = build(:schedule, staged_on: nil)
        expect(schedule).not_to be_valid
      end
    end
  end

  describe "staged_on" do
    it "公演日が指定のフォーマットで出力されること" do
      schedule = build(:schedule)
      expect(schedule.staged_on).to eq("12月31日")
    end
  end

  describe "staged_at" do
    it "開演時間が指定のフォーマットで出力されること" do
      schedule = build(:schedule)
      expect(schedule.staged_at).to eq("13:30")
    end
  end
end
