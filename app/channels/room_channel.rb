class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "room_channel"
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # ActionCable.server.broadcast 'room_channel', message: data['message']
    # Message.create! user_id: 2, room_id: 1, content: data['message']
    # logger.debug("data:" << data.inspect)
    Message.create! user_id: current_user.id, room_id: params['room'], content: data['message']
  end
end
