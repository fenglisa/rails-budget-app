class PurchasesController < ApplicationController
  def index
    @card = Card.find_by_id(params[:card_id])
  end

  def new
    @card = Card.find_by_id(params[:card_id])
    @purchase = Purchase.new
  end

  def create
    @card = Card.find_by_id(params[:card_id])
    @purchase = current_user.purchases.build(purchase_params)
    @purchase.card_id = params[:card_id]
    if @purchase.save
      redirect_to @purchase.card
    else
      render :new
    end
  end

  def edit
    @purchase = current_user.purchases.find_by_id(params[:id])
  end

  def update
    @purchase = current_user.purchases.find_by_id(params[:id])
    if @purchase.update(purchase_params)
      redirect_to @purchase.card
    else
      render :edit
    end
  end

  def destroy
    @purchase = current_user.purchases.find_by_id(params[:id])
    @purchase.destroy
    redirect_to home_path
  end

  private
  def purchase_params
    params.require(:purchase).permit(:date, :amount, :budget_id)
  end
end
