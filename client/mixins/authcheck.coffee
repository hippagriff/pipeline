user = require '../stores/user'

module.exports = 
  statics:
    willTransitionTo: (transition) ->
      unless user.store.isLoggedIn()
        user.requestedNav = transition
        transition.redirect '/login'
      
    
  