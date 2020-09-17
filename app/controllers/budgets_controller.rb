class BudgetsController < ApplicationController
  def index
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.unique_budget?(current_user,budget_params) && @budget.save
      redirect_to home_path
    else
      @error = 'This budget already exists'
      render :new
    end
  end

  def show
    @budget = current_user.budgets.find_by_id(params[:id])
  end

  def edit
    @budget = current_user.budgets.find_by_id(params[:id])
  end

  def update
    @budget = current_user.budgets.find_by_id(params[:id])
    if @budget.update(budget_params)
      redirect_to home_path
    else
      @error = 'This budget already exists'
      render :edit
    end
  end

  def destroy
    @budget = current_user.budgets.find_by_id(params[:id])
    @budget.destroy
    redirect_to home_path
  end

  private
  def budget_params
    params.require(:budget).permit(:name, :amount, :month, :user_id)
  end
end
