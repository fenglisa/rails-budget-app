module BudgetsHelper

  def budget_cards(budget)
    budget.cards.uniq
  end

  def sort_purchases_by_card(budget, card)
    card_purchases = []
    budget.purchases.each{|p| card_purchases << p.amount if p.card_id == card.id}
    card_purchases
  end

  def cash_back_earned(budget)
    cash_back_earned = []
    budget_cards(budget).each do |c|
      card_benefits_categories = []
      c.benefits.each {|b| card_benefits_categories << b.category}
      if card_benefits_categories.include?(budget.name)
        benefit = c.benefits.find_by(category: (budget.name))
        cash_back_earned << ((benefit.cash_back)/100)*((sort_purchases_by_card(budget, c)).sum)
      end
    end
    cash_back_earned.sum
  end

end
