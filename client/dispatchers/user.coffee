{Flux} = require 'delorean.js'
user = require '../stores/user'

UserDispatcher = Flux.createDispatcher
  
  getStores: -> {user: user}

  setLoginData: (data) -> @dispatch('user-login', data)

  logoutUser: (message = '') -> @dispatch('user-logout', message)



module.exports = UserDispatcher