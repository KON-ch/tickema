class CreateUserStages < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stages do |t|
      t.references :stage, foreign_key: true, null: false, index: false
      t.references :user, foreign_key: true, null: false, index: false

      t.timestamps
    end

    add_index :user_stages, [:stage_id, :user_id], unique: true
  end
end
