// we need to import sendMessage from our client/chat.js
import {sendMessage} from '../client/race'

const submitMessage = (inputMessage, inputRaceId) => {
  // Invokes sendMessage, that, in turn, invokes Ruby send_message method
  // that will create a Message instance with ActiveRecord
  sendMessage(inputMessage, inputRaceId)
  // eslint-disable-next-line
  inputMessage.value = ''
  inputMessage.focus()
}

setInterval(()=> {
  submitMessage('coordinates', raceId)
  console.log('sending message')
}, 1000)