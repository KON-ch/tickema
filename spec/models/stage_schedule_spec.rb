require 'rails_helper'

RSpec.describe StageSchedule, type: :model do
  before do
    FactoryBot.create(:stage)
    FactoryBot.create(:schedule)
  end

  describe "StageScheduleモデルのバリデーションテスト" do
    it "正常に登録されること" do
      stage_schedule = FactoryBot.build(:stage_schedule)
      expect(stage_schedule).to be_valid
    end

    context "stage_idが入力されていない場合" do
      it "登録されないこと" do
        stage_schedule = FactoryBot.build(:stage_schedule, stage_id: nil)
        expect(stage_schedule).not_to be_valid
      end
    end

    context "schedule_idが入力されていない場合" do
      it "登録されないこと" do
        stage_schedule = FactoryBot.build(:stage_schedule, schedule_id: nil)
        expect(stage_schedule).not_to be_valid
      end
    end
  end

  describe "staging_date" do
    it "公演日が取得できること" do
      stage_schedule = FactoryBot.build(:stage_schedule)
      expect(stage_schedule.staging_date).to eq("12月31日")
    end
  end

  describe "start_time" do
    it "開演時間が取得できること" do
      stage_schedule = FactoryBot.build(:stage_schedule)
      expect(stage_schedule.start_time).to eq("13:30")
    end
  end
end
