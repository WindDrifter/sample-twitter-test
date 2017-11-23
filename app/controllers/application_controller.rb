class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  def required_login
    if not @current_user
      redirect_to signin_path, alert: "Please login first"
    end
  end
  def is_owner(provided_user_id)
    if @current_user
      return provided_user_id==@current_user.id
    else
      return false
    end
  end

  def is_login
    return session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
    return @current_user
  end
end
