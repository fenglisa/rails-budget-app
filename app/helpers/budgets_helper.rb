module BudgetsHelper

# formatting month and year for budget names
  def current_budget_months
    year = Date.today.strftime(" '%y")
    months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    months.map{|m| m << year}
  end

# return unique cards per budget
  def budget_cards(budget)
    budget.cards.uniq
  end

  def sort_purchases_by_card(budget, card)
    card_purchases = []
    budget.purchases.each{|p| card_purchases << p.amount if p.card_id == card.id}
    card_purchases
  end

# calculates cashback earned per budget
  def cash_back_earned(budget)
    cash_back_earned = []
    budget_cards(budget).each do |c|
      card_benefits_categories = []
      c.benefits.each {|b| card_benefits_categories << b.category}
      if card_benefits_categories.include?(budget.name)
        benefit = c.benefits.find_by(category: (budget.name))
        cash_back_earned << ((benefit.cash_back)/100)*((sort_purchases_by_card(budget, c)).sum)
      elsif card_benefits_categories.include?('All other purchases')
        benefit = c.benefits.find_by(category: 'All other purchases')
        cash_back_earned << ((benefit.cash_back)/100)*((sort_purchases_by_card(budget, c)).sum)
      end
    end
    cash_back_earned.sum.round(2)
  end

end
