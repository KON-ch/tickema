# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe "Scheduleモデルのバリデーションテスト" do
    it "正常に登録されること" do
      schedule = FactoryBot.build(:schedule)
      expect(schedule).to be_valid
    end

    context "開演時間が入力されていない場合" do
      it "登録されないこと" do
        schedule = FactoryBot.build(:schedule, start_time: nil)
        expect(schedule).not_to be_valid
      end
    end

    context "公演日が入力されていない場合" do
      it "登録されないこと" do
        schedule = FactoryBot.build(:schedule, staging_date: nil)
        expect(schedule).not_to be_valid
      end
    end
  end
end
