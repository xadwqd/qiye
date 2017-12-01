class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_for "user_channel_#{params['user_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast("kefu_channel", message: data['message'], user_id: params['user_id'])
  end
end
