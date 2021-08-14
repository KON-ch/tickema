class AddCountToStageCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :stage_customers, :count, :integer, null: false, default: 1
  end
end
