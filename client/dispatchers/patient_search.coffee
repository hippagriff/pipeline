{Flux} = require 'delorean.js'
PatientSearch = require '../stores/patient_search'
patientSearch = new PatientSearch()

PatientSearchDispatcher = Flux.createDispatcher
  
  getStores: -> {patientSearch: patientSearch}

  setSearchResults: (data) -> 
    @dispatch('search-results', data)

  clearData: ->
    @dispatch('search-clear')

module.exports = PatientSearchDispatcher