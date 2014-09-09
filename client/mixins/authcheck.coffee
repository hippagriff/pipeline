user = require '../stores/user'

module.exports = 
  statics:
    willTransitionTo: (transition) ->
      unless user.isLoggedIn()
        user.attemptedTransition = transition
        transition.redirect '/login'
      
    
  