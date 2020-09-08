class UsersController < ApplicationController
  skip_before_action :redirect_if_logged_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def update
    @user = User.find_by_id(params[:id])
  end


  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
