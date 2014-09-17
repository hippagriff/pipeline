{Flux} = require 'delorean.js'
patientSearch = require '../stores/patient_search'

PatientSearchDispatcher = Flux.createDispatcher
  
  getStores: -> {patientSearch: patientSearch}

  setSearchResults: (data) -> 
    @dispatch('search-results', data)

module.exports = PatientSearchDispatcher