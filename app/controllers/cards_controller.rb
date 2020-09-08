class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @card = current_user.cards.find_by_id(params[:id])
  end

  def edit
    @card = current_user.cards.find_by_id(params[:id])
  end

  def update
    @card = current_user.cards.find_by_id(params[:id])
    if @card.update!(card_params)
      redirect_to home_path
    else
      render :edit
    end
  end

  def destroy
    @card = current_user.cards.find_by_id(params[:id])
    @card.destroy
    redirect_to home_path
  end

  private
  def card_params
    params.require(:card).permit(:name, :last_digits, :user_id)
  end
end
