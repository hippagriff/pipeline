{Flux} = require 'delorean.js'

PatientSearch = Flux.createStore
  
  data: null

  actions:
    'search-results': 'setSearchResults'


  setSearchResults: (data) ->
    @data = {}
    @data.results = data
    @emit 'change'


  getState: ->
    {
      results: @data?.results or []
    }



module.exports = new PatientSearch()