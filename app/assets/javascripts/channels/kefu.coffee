App.kefu = App.cable.subscriptions.create "KefuChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    id = '#messages_' + data['user_id']
    $(id).append("<p class='text-left bg-success'>" + data.message + '</p>')

  speak: (msg, user_id) ->
    @perform 'speak', message: msg, user_id: user_id
