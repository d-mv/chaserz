class RaceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    Race.involving(current_user).each do |race|
      stream_from "race_#{race.id}"
    end
  end

  # Called when message-form contents are received by the server
  def send_message(payload)
    puts payload
    # message = Message.new(user: current_user, race_id: payload['id'], body: payload['message'])

    message = JSON.parse(payload["message"])
    location = Location.new(
      user_id: payload['user_id'],
      race_id: payload['race_id'],
      lat: message[0],
      lon: message[1]
    )
    puts location
    location.save!
    ActionCable.server.broadcast "race_#{payload['id']}", message: render(message) if message.save
    puts message
  end

  def render(message)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
