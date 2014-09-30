{Flux} = require 'delorean.js'
patientSearch = require '../stores/patient_search'

PatientSearchDispatcher = Flux.createDispatcher
  
  getStores: -> {patientSearch: patientSearch}

  setSearchResults: (data) -> 
    @dispatch('search-results', data)

  clearData: ->
    @dispatch('search-clear')

module.exports = PatientSearchDispatcher