{Flux} = require 'delorean.js'

ServerRequest = Flux.createStore
  
  data: null

  actions:
    'request-event': 'setStatus'

  setStatus: (status) ->
    @data = {}
    @data.loading = status
    @emit 'change'

  getState: ->
    {
      data: @data
    }

module.exports = new ServerRequest()