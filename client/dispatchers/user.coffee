{Flux} = require 'delorean.js'
UserStore = require '../stores/user'
userStore = new UserStore()

UserDispatcher = Flux.createDispatcher
  
  getStores: -> {user: userStore}

  setLoginData: (data) -> @dispatch('user-login', data)

  updateFieldData: (data) -> @dispatch('update-fields', data)

  logoutUser: (message = '') -> @dispatch('user-logout', message)

  activeRequest: (status) -> @dispatch('request-event', status)


module.exports = UserDispatcher