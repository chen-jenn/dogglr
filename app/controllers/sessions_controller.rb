class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Thanks for signing in"
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:alert] = "Wrong e-mail or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now signed out"
    redirect_to home_path
  end
end
