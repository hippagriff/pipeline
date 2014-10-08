{Flux} = require 'delorean.js'

PatientSearch = Flux.createStore
  
  actions:
    'search-results': 'setSearchResults'
    'search-clear': 'clearData'

  initialize: ->
    @data =
      results: []


  setSearchResults: (data) ->
    @data = {}
    @data.results = data
    @emit 'change'


  getState: -> @data

  clearData: ->
    @data =
      results: []



module.exports = PatientSearch