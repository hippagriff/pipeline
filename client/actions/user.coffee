userDispatcher = require '../dispatchers/user'
Request = require './server_request'

module.exports = 

  setLoginData: (data) -> 
    userDispatcher.setLoginData(data)

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