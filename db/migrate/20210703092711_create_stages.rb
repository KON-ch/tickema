class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :title, null: false, default:""

      t.timestamps
    end
  end
end
