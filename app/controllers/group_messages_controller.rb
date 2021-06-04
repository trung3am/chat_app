class GroupMessagesController < ApplicationController
before_action :require_user


  def new
    @group = GroupMessage.new
    
    @friends_id = []
    friend_list.each do |f|
      if f.user_id != current_user.id
        @friends_id.push(f.user_id)
      end
      if f.f_id != current_user.id
        @friends_id.push(f.f_id)
      end
    end

  end

  def create

    members = params[:group_message][:id]
    if @group = GroupMessage.create(groupname: params[:group_message][:groupname], bilateral: false, groupadmin_id: current_user.id)
      if Message.create(user_id: current_user.id, group_message_id: @group.id, body: "Group created", initiate: true)
        members.each do |m|
          if m.to_i != 0
            Message.create(user_id: m, group_message_id: @group.id, body: User.find(m).username + " was invited to the group", initiate: true)
          end
        end
      end
    end
    session[:group_message_id] = @group.id
    redirect_to root_path
  end

  def show
    
    @group = GroupMessage.find(params[:id])
    
    if @group.bilateral || Message.where(user_id: current_user.id, group_message_id: params[:id]).empty?
      flash[:error] = "Failed to execute"
      redirect_to root_path
    else
      session[:group_message_id] = params[:id]
      @gusers = User.joins(:messages).where(messages: {group_message_id: @group.id}).group("id")
      @count = User.joins(:messages).where(messages: {group_message_id: @group.id}).distinct.count("id")
    end
  end

  def edit
    @group = GroupMessage.find(params[:id])
    @gusers = User.joins(:messages).where(messages: {group_message_id: @group.id}).group("id")
    if @group.bilateral || Message.where(user_id: current_user.id, group_message_id: params[:id]).empty?
      redirect_to root_path
    else
      @friend = User.execute_sql("select distinct users.id, f_id, username, about, accept, friends.id as friend_id 
        from users inner join friends on users.id = friends.f_id where friends.user_id = ? 
        union select distinct users.id, f_id, username, about, accept, friends.id as friend_id  from users inner join 
        friends on users.id == friends.user_id where friends.f_id = ?  order by username", current_user.id, current_user.id)
    end
  end

  def update
    if Message.create(user_id: params[:id], body: User.find(params[:id]).username + " was invited to group", initiate: true, group_message_id: params[:format])
      flash[:success] = User.find(params[:id]).username + " was invited to group"
    else
      flash[:error] = "Failed to add to group"
    end
    redirect_to edit_group_message_path(params[:format])
  end

  def destroy

    Message.where(group_message_id: params[:id]).delete_all
    GroupMessage.find(params[:id]).delete
    session[:group_message_id] = 1
    redirect_to root_path


  end




end