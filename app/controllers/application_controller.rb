class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in, :new_budget_category, :budget_cards, :sort_purchases_by_card, :cash_back_earned
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
      current_user.budgets.build(name: params[:benefit][:category], amount: 0, month: Date.today.strftime('%B')).save
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
    cash_back_earned.sum
  end

end
