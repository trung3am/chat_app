class FriendsController < ApplicationController
  before_action :require_user
  def index
    @friend = User.execute_sql("select distinct users.id, f_id, username, about, accept, friends.id as friend_id 
      from users inner join friends on users.id = friends.f_id where friends.user_id = ? 
      union select distinct users.id, f_id, username, about, accept, friends.id as friend_id  from users inner join 
      friends on users.id = friends.user_id where friends.f_id = ?  order by username", current_user.id, current_user.id)
  end


  def create
    fr_id = params[:format]

    if current_user.id == fr_id || !friend_list.where(user_id: fr_id).empty? || !friend_list.where(f_id: fr_id).empty? 
      flash[:alert] = "Cannot add friend"

      redirect_back(fallback_location: root_path)
    else
      friend = Friend.new(user_id: current_user.id, f_id: fr_id)
      
      if friend.save
        group_search_name = "*" + current_user.username + "**" + User.find(fr_id).username + "*"
        temp = GroupMessage.where("groupname like ? and bilateral = true", "%" + group_search_name + "%")
        temp2 = GroupMessage.where("groupname like ? and bilateral = true", "%" + User.find(fr_id).username + current_user.username + "%")
        if temp.empty? && temp2.empty?
          temp3 = GroupMessage.create(groupname: group_search_name , bilateral: true)
          Message.create(user_id: current_user.id, body: current_user.username + "Wanted to be friend", group_message_id: temp3.id, initiate: true)
          Message.create(user_id: fr_id, body: "Friend request pending", group_message_id: temp3.id, initiate: true)
        session[:group_message_id] = temp3.id
        end
        
        flash[:success] = "Friend request sent"
        redirect_back(fallback_location: root_path)
      else

        flash[:alert] = "Cannot add friend"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    
    request = Friend.find(params[:id])
    if request.user_id != current_user.id
      f = User.find(request.user_id).username
   
      request.accept = true
      
      if request.save
        flash[:success] =  f +  " is now your friend!"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = "Failed to accept"
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "Cannot accept friend request"
    end
  end

  def destroy
    request = Friend.find(params[:id])
    if request.user_id != current_user.id
      f = User.find(request.user_id).username
    else
      f = User.find(request.f_id).username
    end

    if request.delete
      flash[:success] = "Successfully break up with " + f 
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Failed to remove"
      redirect_back(fallback_location: root_path)
    end
  end




end