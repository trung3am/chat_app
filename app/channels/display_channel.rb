class DisplayChannel < ApplicationCable::Channel
  def subscribed

    stream_for group_message
    
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def group_message
    
    GroupMessage.find(params[:group_id])
  end

end
