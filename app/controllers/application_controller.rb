class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in, :new_budget_category, :budget_cards, :sort_purchases_by_card, :cash_back_earned, :card_budgets, :budget_cash_back, :purchase_total, :current_budgets
  before_action :redirect_if_logged_out

  def current_user
    @user ||= User.find_by_id(session[:user_id])
  end

  def logged_in
    !!session[:user_id]
  end

  def redirect_if_logged_out
    unless logged_in
      redirect_to root_path
    end
  end

  def new_budget_category
    budget_names = []
    current_user.budgets.each {|b| budget_names << b.name}
    if params[:benefit][:category] != "Other" && !budget_names.include?(params[:benefit][:category])
      current_user.budgets.build(name: params[:benefit][:category], amount: 0, month: Date.today.strftime("%B '%y")).save
    end
  end

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
    cash_back_earned.sum.round(2)
  end

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
        cash_back_earned = (((benefit.cash_back)/100)*((sort_purchases_by_card(b, card)).sum)).round(2)
        budget_earnings[b.name] = cash_back_earned
      end
    end
    budget_earnings
  end

  def purchase_total(parent)
    parent_purchases = []
    if parent == @card
      current_user.purchases.each do |p|
        parent_purchases << p.amount if p.card_id == parent.id
      end
    elsif parent == @budget
      current_user.purchases.each do |p|
        parent_purchases << p.amount if p.budget_id == parent.id
      end
    end
    parent_purchases.sum
  end

  def current_budgets
    budgets_this_month = []
    current_user.budgets.each{|b| budgets_this_month << b if b.month.include?(Date.today.strftime("%B '%y"))}
    budgets_this_month
  end

end
