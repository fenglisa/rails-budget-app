class Benefit < ApplicationRecord
  validates :cash_back, presence: true
  validates :category, presence: true
  belongs_to :card

# benefit categories
  def categories
    ['Gas','Groceries','Restaurants','All other purchases']
  end

# prevents adding an already added benefit category
# used in new benefits form
  def disabled_categories(card)
    card_benefits = []
    card.benefits.each{|b| card_benefits << b.category}
    card_benefits & categories
  end

# common cashback percentages
  def percentage_cash_back
    [1,1.5,2,3,5,6]
  end

end
