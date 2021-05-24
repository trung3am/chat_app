class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  def new

  end
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:group_message_id] = 1
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash[:error] = "Log in failed"
      render 'new'
      
    end
  end

  def update
    session[:group_message_id] = params[:session][:group_message_id]


    redirect_to root_path
  end


  def destroy
    require_user
    session[:user_id] = nil
    session[:group_message_id] = 1
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  
  end

end