userDispatcher = require '../dispatchers/user'
Request = require './server_request'
Router = require 'react-router'

module.exports = 

  attemptLogin: (username, password) ->
    new Request(
      url: '/api/login'
      headers:
        username: username
        password: password
      authenticate: off
    ).done(@setLoginData).error(->
      console.log 'error'
    )

  setLoginData: (data) -> userDispatcher.setLoginData(data)


  attemptLogout: (message) ->
    new Request(
      url: '/api/logout'
    ).done( =>
      @logoutUser(message)
      Router.replaceWith '/login'
    ).error( ->
      console.log 'error'
    )

  logoutUser: (message) -> userDispatcher.logoutUser(message)