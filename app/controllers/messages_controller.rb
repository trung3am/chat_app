class MessagesController < ApplicationController

  def create

    message = current_user.messages.build(message_params)
    
    if message.save
      m = message_render(message)

      group = message.group_message
      ChatroomChannel.broadcast_to  group , ms: m
      DisplayChannel.broadcast_to group , dp: m, gr: message.group_message_id
      
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

