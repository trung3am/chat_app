import consumer from "./consumer"


$(document).on('turbolinks:load', function() {
consumer.subscriptions.create(
  {channel: "ChatroomChannel",
  group_id: $('#group-messages').attr('data_group_id')
}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    
    $('#message-container').append(data.ms);
    if ($('#messages').length > 0) {
      $('#messages').scrollTop($('#messages')[0].scrollHeight);
    }

  }
}); 
})