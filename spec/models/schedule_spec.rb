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

  describe "data" do
    before do
      FactoryBot.create(:stage)
      FactoryBot.create(:schedule)
      FactoryBot.create(:stage_schedule)
    end

    let(:stage) { Stage.first}
    let(:schedule) { Schedule.first}

    it "日程情報が取得できること" do
      expect(schedule.data(stage_id: stage.id)).to eq ({ id: 1, staging_date: "12月31日", start_time: "13:30" })
    end
  end

  describe "staging_date" do
    it "公演日が指定のフォーマットで出力されること" do
      schedule = FactoryBot.build(:schedule)
      expect(schedule.staging_date).to eq("12月31日")
    end
  end

  describe "start_time" do
    it "開演時間が指定のフォーマットで出力されること" do
      schedule = FactoryBot.build(:schedule)
      expect(schedule.start_time).to eq("13:30")
    end
  end
end
