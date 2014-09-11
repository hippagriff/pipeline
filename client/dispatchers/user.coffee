{Flux} = require 'delorean.js'
user = require '../stores/user'

UserDispatcher = Flux.createDispatcher

  setLoginData: (data) -> @dispatch('user-login', data)

  getStores: -> {user: user}


module.exports = UserDispatcher