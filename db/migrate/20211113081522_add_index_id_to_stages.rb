class AddIndexIdToStages < ActiveRecord::Migration[6.1]
  def change
    add_index :stages, :id
  end
end
