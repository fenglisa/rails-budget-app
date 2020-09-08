class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in
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
end
