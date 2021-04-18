class SessionsController < ApplicationController
  # login functionality
  def create_session
    @user = User.find_by(username: login_params[:username])
    if @user&.authenticate(login_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Successfully logged in."
      redirect_to apartments_path and return
    end
    flash[:warning] = "Wrong username or password."
    redirect_to login_path
  end

  def create_user
    if User.find_by(username: register_params[:username])
      flash[:warning] = "User with this username already exists."
      redirect_to register_path and return
    end
    @user = User.new(register_params)
    @user.email = "#{register_params[:username]}@columbia.edu"
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successfully registered."
      redirect_to apartments_path and return
    end
    flash[:warning] = "Password does not match."
    redirect_to register_path
  end

  # Log out functionality
  def delete_session
    session.delete(:user_id)
    flash[:notice] = "Successfully logged out."
    redirect_to apartments_path
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end

  def register_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
