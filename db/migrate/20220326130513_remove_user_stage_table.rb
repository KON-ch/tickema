class RemoveUserStageTable < ActiveRecord::Migration[6.1]
  def change
    remove_index :user_stages, ["stage_id", "user_id"], name: "index_user_stages_on_stage_id_and_user_id", unique: true

    drop_table "user_stages" do |t|
      t.bigint "stage_id", null: false
      t.bigint "user_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

  end
end
