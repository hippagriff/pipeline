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
    {menuIsOpen, toggleMenu} = @props
    {results} = @state.stores.patientSearch

    className = 'search-container'
    if menuIsOpen then className += ' menu-open'

    patients = []
    patients.push((SearchResult {
      patient: patient
      key: patient.id
    }, [])) for patient in results

    div {
      className: className
      id: 'search'
    }, [
      SearchBar {
        key: 'searchBar'
        handleLogout: @handleLogout
        executeSearch: @executeSearch
        toggleMenu
      }, []
      ul {
        className: 'results-container'
        key: 'results'
      }, patients
    ]


  handleLogout: -> userActions.attemptLogout('')

  executeSearch: (searchTerm) -> searchActions.executeSearch(searchTerm)





module.exports = Search
