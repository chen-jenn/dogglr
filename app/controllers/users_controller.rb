class UsersController < ApplicationController
  def new #show a page to create a new user
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:notice] = "Thanks for signing up!"
      redirect_to home_path
    else #else stay on the same page
      render :new
    end
  end

  def edit #prepopulate it with user information
    @u = current_user
  end

  def update
    @u = current_user
    if @u.update user_params
      redirect_to edit_user_path(@u)
    else
      render :edit
    end
  end

  def change_password #just generating the view page
    @u = current_user
  end

  def update_password
    @u = current_user
    if @u.authenticate(params[:user][:current_password]) # method from bcrypt and has_secure_password
      @u.update user_params
      flash[:notice] = "Password changed!"
      redirect_to change_password_path 
    else
      flash[:alert] = "Wrong current password"
      redirect_to change_password_path
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end

end
