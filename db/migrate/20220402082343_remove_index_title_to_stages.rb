class RemoveIndexTitleToStages < ActiveRecord::Migration[6.1]
  def change
    remove_index :stages, ["id"], name: "index_stages_on_id"
    remove_index :stages, ["title"], name: "index_stages_on_title", unique: true
  end
end
