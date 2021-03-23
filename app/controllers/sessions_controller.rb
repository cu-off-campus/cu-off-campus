class SessionsController < ApplicationController
  def create_session
    @user = User.find_by(username: login_params[:username])
    if @user&.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path and return
    end
    flash[:warning] = "Wrong username or password."
    redirect_to login_path
  end

  def create_user
    @user = User.new(register_params)
    @user.email = "#{register_params[:username]}@columbia.edu"
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path and return
    end
    flash[:warning] = "Password does not match."
    redirect_to register_path
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end

  def register_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
