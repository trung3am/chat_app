class ChatroomController < ApplicationController
  before_action :require_user
  
  def index
    @message = Message.new
    @messages = Message.where(group_message_id: current_group.id).custom_display
    temp = []
    temp2 = Message.execute_sql("select  MAX(id) as id from messages 
    where group_message_id in (select group_message_id from messages where user_id = ?)
    group by messages.group_message_id order by id DESC", current_user.id)

    temp2.each do |i|
      i.each do |k,v|
        temp.push(v)
      end
    end
    @displays = Message.where(id: temp).order("id DESC")
    @group = GroupMessage.joins(:messages).where(messages: {id: temp}).ids

  end



  
end