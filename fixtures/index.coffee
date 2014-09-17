login = require './login'
logout = require './logout'
patientSearch = require './patient_search'

module.exports = (app) ->
  app.get('/api/login', login)
  app.get('/api/logout', logout)
  app.get('/api/patient', patientSearch)