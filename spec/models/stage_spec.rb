# frozen_string_literal: true

require "rails_helper"

RSpec.describe Stage, type: :model do
  before { create(:user) }

  describe "validates" do
    subject { Stage.new(title: title, user: build(:user)) }

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
end
