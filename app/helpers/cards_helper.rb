module CardsHelper

# return unique budgets per card
  def card_budgets(card)
    card.budgets.uniq
  end

  def sort_purchases_by_card(budget, card)
    card_purchases = []
    budget.purchases.each{|p| card_purchases << p.amount if p.card_id == card.id}
    card_purchases
  end

# calculates cashback earned per card
  def budget_cash_back(card)
    card_benefits_categories = []
    card.benefits.each {|b| card_benefits_categories << b.category}
    other_purchases = []
    budget_earnings = {}
    card_budgets(card).each do |b|
      if card_benefits_categories.include?(b.name)
        benefit = card.benefits.find_by(category: (b.name))
        cash_back_earned = (((benefit.cash_back)/100)*((sort_purchases_by_card(b, card)).sum)).round(2)
        budget_earnings[benefit.category] = cash_back_earned
      elsif card_benefits_categories.include?('All other purchases')
        benefit = card.benefits.find_by(category: 'All other purchases')
        other_purchases << (((benefit.cash_back)/100)*((sort_purchases_by_card(b, card)).sum)).round(2)
      end
    end
    if card_benefits_categories.include?('All other purchases')
      cash_back_earned = other_purchases.sum.round(2)
      budget_earnings['All other purchases'] = cash_back_earned
    end
    budget_earnings
  end
end
