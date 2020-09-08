class PurchasesController < ApplicationController
  def new
    @user = current_user
    @purchase = Purchase.new
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)
    if @purchase.save
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @purchase = current_user.purchases.find_by_id(params[:id])
  end

  def edit
    @purchase = current_user.purchases.find_by_id(params[:id])
  end

  def update
    @purchase = current_user.purchases.find_by_id(params[:id])
    if @purchase.update!(purchase_params)
      redirect_to home_path
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
    params.require(:purchase).permit(:date, :amount, :card_id, :budget_id, :user_id)
  end
end
