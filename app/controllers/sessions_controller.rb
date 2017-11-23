class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Signed in successfully"
      redirect_to root_path
    else
      flash.keep[:alert] = "Wrong crenditials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out"
  end
end
