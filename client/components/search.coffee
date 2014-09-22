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
      key: patient.id
    }, [])) for patient in results

    searchClearClass = 'search-clear'
    if @state.searchTerm.length is 0 then searchClearClass += ' is-hidden'


    div {
      className: 'search-container'
    }, [
      div {
        className: 'search-bar'
      }, [
        input {
          ref:'searchField'
          className: 'search-input'
          type: 'text'
          placeholder: 'Search Patients'
          onKeyUp: @executeSearch
        }, []
        button {
          className: searchClearClass
          onClick: @clearSearch
          title: 'Clear Search'
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


  getInitialState: -> {
    searchTerm: ''
  }

  componentDidMount: -> @refs.searchField.getDOMNode().focus()

  handleLogout: -> userActions.attemptLogout('')

  executeSearch: (e) ->
    searchTerm = @refs.searchField.getDOMNode().value
    searchActions.executeSearch(searchTerm)

    @setState({searchTerm})

  clearSearch: (e) ->
    @refs.searchField.getDOMNode().value = ''
    @executeSearch(e);






module.exports = Search
