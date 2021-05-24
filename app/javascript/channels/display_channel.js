import consumer from "./consumer"


function sub(element){
    consumer.subscriptions.create(
      {channel: "DisplayChannel",
      group_id: element
    }, {
      connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        $(`#side-${data.gr}-mess`).html(data.dp);
        var temp = $(`#${data.gr}`).html();
        $("div").remove(`#${data.gr}`);
        $('#group-display').prepend(temp);
      }
    
      
    });}
  

$(document).on('turbolinks:load', function() {
  
  
  var g = $('#group-display').attr('data_group_id');
  g = g.substring(1,g.length -1)
  g = g.split(",")  
  g.forEach(sub)
})