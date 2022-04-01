class CreateCustomerStageHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_stage_histories do |t|
      t.references :customer, foreign_key: true, null: false, index: false
      t.references :stage, foreign_key: true, null: false, index: false

      t.timestamps
    end
  end
end
