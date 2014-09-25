{Flux} = require 'delorean.js'
request = require '../stores/server_request'

RequestDispatcher = Flux.createDispatcher
  
  getStores: -> {request: request}
  
  setStatus: (status) -> 
    @dispatch('request-event', status)


module.exports = RequestDispatcher