class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :title, null: false

      t.timestamps
    end

    add_index :stages, [:title], unique: true
  end
end
