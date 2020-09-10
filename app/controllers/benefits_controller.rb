class BenefitsController < ApplicationController
  def new
    @card = Card.find_by_id(params[:card_id])
    @benefit = Benefit.new
  end

  def create
    @card = Card.find_by_id(params[:card_id])
    @benefit = current_user.benefits.build(benefit_params)
    @benefit.card_id = params[:card_id]
    if @benefit.save
      new_budget_category
      redirect_to @benefit.card
    else
      render :new
    end
  end

  def edit
    @benefit = current_user.benefits.find_by_id(params[:id])
  end

  def update
    @benefit = current_user.benefits.find_by_id(params[:id])
    if @benefit.update(benefit_params)
      redirect_to @benefit.card
    else
      render :edit
    end
  end

  def destroy
    @benefit = current_user.benefits.find_by_id(params[:id])
    @benefit.destroy
    redirect_to home_path
  end

  private
  def benefit_params
    params.require(:benefit).permit(:cash_back, :category)
  end
end
