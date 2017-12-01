class KefuChannel < ApplicationCable::Channel
  def subscribed
    stream_from "kefu_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    UserChannel.broadcast_to("user_channel_#{data['user_id']}", message: data['message'])
  end
end

