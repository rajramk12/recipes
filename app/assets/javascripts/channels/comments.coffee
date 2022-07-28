App.comments = App.cable.subscriptions.create "CommentsChannel",

connected: ->

disconnected: ->

received:(data)-> $("#comments .comment-fix:first").prepend(data)


