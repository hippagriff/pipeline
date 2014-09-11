login = require './login'

module.exports = (app) ->
  app.get('/api/login', login)