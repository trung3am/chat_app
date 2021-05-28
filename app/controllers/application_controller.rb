class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token

  helper_method :current_user, :logged_in?, :current_group, :friend_name, :friend_list, :require_user
  def current_group
    if !GroupMessage.where(id: session[:group_message_id]).empty?
      @current_group = GroupMessage.find(session[:group_message_id])
    else
      @current_group = GroupMessage.find(1)
    end
  end


  def friend_name(group_name)
    friend = group_name
    friend.slice!(current_user.username)
    @friend_name = friend.delete("*")
  end



  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must log in to perform this action"
      redirect_to login_path  
    end
  end

  def require_logged_out
    if logged_in?
      flash[:error] = "You must log out to perform this action"
      redirect_to root_path
    end
  end

  def friend_list
    @friend_list = Friend.where(user_id: current_user.id).or(Friend.where(f_id: current_user.id))

  end







end
