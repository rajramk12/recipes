//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require cable
// require turbolinks
//= require_tree .


function scrollToBottom(){
  if($('#messages').length > 0) {
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
};

function submitMessage(event){
  event.preventDefault();
  $('#new_message').submit();
};

$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) {
    submitMessage(event);
  }
});

$(document).on('click', '[data-send~=message]', function(event) {
  submitMessage(event);
});

$(document).on('turbolinks:load', function() {
  $("#new_message").on("ajax:complete", function(e, data, status) {
    $('#message_content').val('');
  })
  scrollToBottom();
});
