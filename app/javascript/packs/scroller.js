const goDown = document.getElementById('go-down')
const landingOne = document.getElementById('landing-one')
const landingTwo = document.getElementById('landing-two')

goDown.addEventListener('click', event => {
  landingOne.classList = 'landing-wrapper-down'
  landingTwo.classList = 'landing-wrapper-down'
})

window.addEventListener('scroll', event => {
  landingOne.classList = 'landing-wrapper-down'
  landingTwo.classList = 'landing-wrapper-down'
})