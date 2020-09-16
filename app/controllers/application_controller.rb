class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in, :new_budget_category
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
    current_user.budgets.each {|b| budget_names << b.name.capitalize}
    if params[:benefit][:category] != "All other purchases" && !budget_names.include?(params[:benefit][:category])
      current_user.budgets.build(name: params[:benefit][:category], amount: 0, month: Date.today.strftime("%B '%y")).save
    end
  end

end
