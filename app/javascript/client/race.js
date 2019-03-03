import createChannel from './cable'

let callback

const raceChannel = createChannel('RaceChannel', {
  received({message}) {
    if (callback) callback.call(null, message)
  }
})
// Sending a message: "perform" method calls a respective Ruby method
// defined in chat_channel.rb. That's your bridge between JS and Ruby!
const sendMessage = (message, raceId, userId) =>{
  raceChannel.perform('send_message',{message: message, race_id: raceId, user_id: userId})
}
// Getting a message: this callback will be invoked once we receive
// something over ChatChannel
const setCallback = (fn) => {
  callback = fn
}

export {sendMessage, setCallback}