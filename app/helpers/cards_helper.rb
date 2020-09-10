module CardsHelper
  def card_budgets(card)
    card.budgets.uniq
  end

  def budget_cash_back(card)
    card_benefits_categories = []
    card.benefits.each {|b| card_benefits_categories << b.category}
    budget_earnings = {}
    card_budgets(card).each do |b|
      if card_benefits_categories.include?(b.name)
        benefit = card.benefits.find_by(category: (b.name))
        cash_back_earned = ((benefit.cash_back)/100)*((sort_purchases_by_card(b, card)).sum).round(2)
        budget_earnings[b.name] = cash_back_earned
      end
    end
    budget_earnings
  end
end
