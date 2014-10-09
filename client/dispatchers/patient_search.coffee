{Flux} = require 'delorean.js'
PatientSearch = require '../stores/patient_search'

PatientSearchDispatcher = Flux.createDispatcher
  
  getStores: -> {patientSearch: new PatientSearch()}

  setSearchResults: (data) -> 
    @dispatch('search-results', data)

  clearData: ->
    @dispatch('search-clear')

module.exports = PatientSearchDispatcher