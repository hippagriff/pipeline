React = require 'react/addons'
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup
{Flux} = require 'delorean.js'
authCheck = require '../mixins/authcheck'

userActions = require '../actions/user'
searchActions = require '../actions/patient_search'

SearchBar = require './search_bar'
SearchResult = require './search_result_patient'



Search = React.createClass

  mixins: [authCheck, Flux.mixins.storeListener]
  
  render: ->
    {div, ul, input, button} = React.DOM
    {results} = @state.stores.patientSearch

    #console.log @state.showSearchBar

    #searchBar = []
    #if @state.showSearchBar
    #  searchBar.push(SearchBar {
    #    key: 'searchBar'
    #    handleLogout: @handleLogout
    #    executeSearch: @executeSearch
    #  }, [])

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


  getInitialState: -> 
    {
      showSearchBar: no
    }

  componentDidMount: -> 
    @setState({showSearchBar: yes})

  handleLogout: -> userActions.attemptLogout('')

  executeSearch: (searchTerm) ->
    searchActions.executeSearch(searchTerm)
    @setState({searchTerm})







module.exports = Search
