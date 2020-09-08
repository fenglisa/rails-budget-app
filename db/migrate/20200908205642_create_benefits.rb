class CreateBenefits < ActiveRecord::Migration[6.0]
  def change
    create_table :benefits do |t|
      t.float :cash_back
      t.string :category
      t.belongs_to :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
