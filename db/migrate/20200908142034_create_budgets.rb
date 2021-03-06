class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.string :name
      t.float :amount
      t.string :month
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
