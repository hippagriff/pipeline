React = require 'react'
{Flux} = require 'delorean.js'
authCheck = require '../mixins/authcheck'

userActions = require '../actions/user'
searchActions = require '../actions/patient_search'

searchResult = require './patient_search_result'


Search = React.createClass

  mixins: [authCheck, Flux.mixins.storeListener]
  
  render: ->
    {div, ul, input, button} = React.DOM
    {results} = @state.stores.patientSearch

    #console.log @state.stores.patientSearch.results
    patients = []
    patients.push((searchResult {
      patient: patient
      key: patient.identifier[0].value
    }, [])) for patient in results


    div {
      className: 'search-container'
    }, [
      div {
        className: 'search-bar'
      }, [
        input {
          ref:'searchField'
          className: 'search-input'
          type: 'search'
          placeholder: 'Search Patients'
          onKeyUp: @executeSearch
        }, []
        button {
            className: 'search-logout-btn'
            onClick: @handleLogout
            title: 'Logout'
        }, ['⇥']
      ]
      ul {
        className: 'search-results-container'
      }, [patients]
    ]


  getInitialState: -> {}

  componentDidMount: -> @refs.searchField.getDOMNode().focus()

  handleLogout: -> userActions.attemptLogout('')

  executeSearch: (e) ->
    term = @refs.searchField.getDOMNode().value
    searchActions.executeSearch(term)



module.exports = Search
