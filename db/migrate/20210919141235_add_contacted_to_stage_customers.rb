class AddContactedToStageCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :stage_customers, :contacted, :boolean, null: false, default: false
  end
end
