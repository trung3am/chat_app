class MessagesController < ApplicationController
before_action :require_user
  def create

    message = current_user.messages.build(message_params)
    
    if message.save
      m = message_render(message)

      group = message.group_message
      ChatroomChannel.broadcast_to  group , ms: m
      DisplayChannel.broadcast_to group , dp: m, gr: message.group_message_id
      
    end
  end

  def destroy
    if Message.where(user_id: params[:format], group_message_id: session[:group_message_id]).delete_all
      flash[:success] = User.find(params[:format]).username + " is successfully removed from group"
    else
      flash[:error] = "Failed to remove"
    end
    if params[:format] = current_user.id
      session[:group_message_id] = 1
      redirect_to root_path
      
    else
      redirect_back(fallback_location: root_path)
    end

  end


  private

  def message_params
    params.require(:message).permit(:body,:group_message_id)
  end

  def message_render(message)

    render(partial: 'message', locals: {message: message})

  end

end

