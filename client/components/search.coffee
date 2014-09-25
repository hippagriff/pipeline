React = require 'react'
{Flux} = require 'delorean.js'
authCheck = require '../mixins/authcheck'

userActions = require '../actions/user'
searchActions = require '../actions/patient_search'

SearchBar = require './search_bar'
SearchResult = require './search_result_patient'



Search = React.createClass

  mixins: [authCheck, Flux.mixins.storeListener]
  
  render: ->
    {div, ul} = React.DOM
    {results} = @state.stores.patientSearch

    patients = []
    patients.push((SearchResult {
      patient: patient
      key: patient.id
    }, [])) for patient in results

    div {
      className: 'search-container'
      id: 'search'
    }, [
      SearchBar {
        key: 'searchBar'
        handleLogout: @handleLogout
        executeSearch: @executeSearch
      }, []
      ul {
        className: 'results-container'
        key: 'results'
      }, patients
    ]


  handleLogout: -> userActions.attemptLogout('')

  executeSearch: (searchTerm) -> searchActions.executeSearch(searchTerm)





module.exports = Search
