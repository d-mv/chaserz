const signInButtons = document.getElementsByClassName('sign-in')
const registerInButtons = document.getElementsByClassName('register')
const profileButtons = document.getElementsByClassName('profile')
const toMenuButtons = document.getElementsByClassName('to-menu')
const racesButtons = document.getElementsByClassName('races')
const ranksButtons = document.getElementsByClassName('ranks')
const logoutButtons = document.getElementsByClassName('logout')
const userId = document.querySelector('body').id




Array.from(signInButtons).forEach ((button)=>{
  button.addEventListener('click', event => {
    console.log(`Pressed button %c'sign in'`, 'color:grey;background-color: gainsboro; padding: 3px 5px;')
    window.location.href = '/users/sign_in'
  })
})

Array.from(registerInButtons).forEach((button) => {
  button.addEventListener('click', event => {
    console.log(`Pressed button %c'REGISTER'`, 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px;')
    window.location.href = '/users/sign_up'
  })
})

Array.from(profileButtons).forEach((button) => {
  button.addEventListener('click', event => {
    console.log(`Pressed button %c'PROFILE'`, 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px;')
    window.location.href = `/users/${userId}`
  })
})


Array.from(toMenuButtons).forEach((button) => {
  button.addEventListener('click', event => {
    console.log(`Pressed button %c'PROFILE'`, 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px;')
    window.location.href = '/'
  })
})


Array.from(racesButtons).forEach((button) => {
  button.addEventListener('click', event => {
    console.log(`Pressed button %c'RACES'`, 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px;')
    window.location.href = `/races`
  })
})

Array.from(ranksButtons).forEach((button) => {
  button.addEventListener('click', event => {
    console.log(`Pressed button %c'RANKS'`, 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px;')
    window.location.href = `/users/ranks`
  })
})

// Array.from(logoutButtons).forEach((button) => {
//   button.addEventListener('click', event => {
//     console.log(`Pressed button %c'LOG OUT'`, 'color: white; background-color:  orange; padding: 2px 5px; border-radius: 2px;')
//     window.location.href = ` /users/sign_out`
//   })
// })


// console.log(`Pressed card %c${cocktailId}`, 'color:green;background-color: LightGreen; padding: 3px 5px;')

// console.log(`Pressed button %c'sing in'`, 'color:grey;background-color: gainsboro; padding: 3px 5px;')


// console.log(`Hover over card %c${cocktailId}`, 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px;')

// /users/sign_in
