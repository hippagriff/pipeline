LoginComponent = require '../components/login/login'
userAuth = require '../user_auth'

module.exports = 
  statics:
    willTransitionTo: (transition) ->
      unless userAuth.isLoggedIn()?
        LoginComponent.requestedNav = transition
        transition.redirect '/login'
      
    
  