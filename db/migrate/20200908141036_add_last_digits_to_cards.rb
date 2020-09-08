class AddLastDigitsToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :last_digits, :integer
  end
end
