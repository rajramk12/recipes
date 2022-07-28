App.comments = App.cable.subscriptions.create "ChatroomChannel",

connected: ->

disconnected: ->

received:(data)->
  scrollToBottom()
  $("#messages").append(data)

scrollToBottom = ->
    if $('#messages').length > 0
      last_message = $('#messages')[0]
      last_message.scrollTop = last_message.scrollHeight -
                                          (last_message.clientHeight)
    return

# $(document).on('turbolinks:load', function() {
#   $("#new_message").on("ajax:complete", function(e, data, status) {
#     $('#message_content').val('');
#   })
#   scrollToBottom();
# });

jQuery(document).on 'turbolinks:reload', ->
  scrollToBottom()
  return
