import {setCallback} from '../client/race'

let racers = {}

setCallback(message => {
  // console.log(`SERVER: ${message}, IAM: ${userId}`)
  racers = message

})
console.log(racers)