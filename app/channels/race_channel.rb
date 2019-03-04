require 'colorize'

class RaceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    Race.involving(current_user).each do |race|
      stream_from "race_#{race.id}"
    end
  end
  # Called when message-form contents are received by the server
  def send_message(payload)
    message = JSON.parse(payload["message"])
    location = Location.where(user_id: payload['user_id'], race_id: payload['race_id'])
    if location.size.zero?
      Location.create(user_id: payload['user_id'], race_id: payload['race_id'], lat: message[0], lon: message[1])
    else
      location[0].update(lat: message[0], lon: message[1])
    end
    ActionCable.server.broadcast "race_#{payload['race_id']}", message: form_message(payload['race_id'])
  end

  def form_message(race_id)
    locations = Location.where(race_id: race_id)
    return '' if locations.size.zero?

    message_hash = {}
    locations.each { |loc| message_hash[loc.user_id] = [loc.lat, loc.lon] }
    return JSON.generate(message_hash)
  end

  def unsubscribed
    stop_all_streams
  end
end
