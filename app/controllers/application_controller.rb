class ApplicationController < ActionController::Base


  helper_method :current_user, :logged_in?, :current_group, :friend_name
  def current_group
    @current_group ||= GroupMessage.find(session[:group_message_id]) if session[:group_message_id]
  end


  def friend_name(group_name)
    friend = group_name
    friend.slice!(current_user.username)
    @friend_name = friend
  end

  def last_sent(group_id)
    Message.where(group_message_id: group_id).last

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

end
