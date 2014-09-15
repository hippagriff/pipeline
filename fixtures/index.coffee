login = require './login'
logout = require './logout'

module.exports = (app) ->
  app.get('/api/login', login)
  app.get('/api/logout', logout)