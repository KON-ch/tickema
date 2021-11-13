class AddIndexIdToContacts < ActiveRecord::Migration[6.1]
  def change
    add_index :contacts, :id
  end
end
