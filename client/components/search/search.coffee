React = require 'react/addons'
{TransitionGroup} = React.addons
{Flux} = require 'delorean.js'
authCheck = require '../../mixins/authcheck'

userActions = require '../../actions/user'
searchActions = require '../../actions/patient_search'

SearchBar = require './search_bar'
SearchResult = require './search_result_patient'


Search = React.createClass
  
  displayName: 'Search'

  mixins: [authCheck, Flux.mixins.storeListener]
  
  render: ->
    {div, ul} = React.DOM
    {menuIsOpen, toggleMenu} = @props
    {results} = @state.stores.patientSearch

    className = 'search-container'
    if menuIsOpen then className += ' menu-open'

    bar= []
    bar.push((SearchBar {
      key: 'searchBar'
      handleLogout: @handleLogout
      startLogout: @startLogout
      executeSearch: @executeSearch
      toggleMenu
    })) if @state.showBar

    patients = []
    patients.push((SearchResult {
      patient: patient
      key: patient.id
    }, [])) for patient in results

    div {
      className: className
      id: 'search'
      onClick: @toggleMenu
    }, [
      TransitionGroup {
        transitionName: 'searchBar'
        key: 'searchBar'
      }, bar
      ul {
        className: 'results-container'
        key: 'results'
      }, patients
    ]

  
  getInitialState: -> {showBar: no}


  componentDidMount: -> @setState {showBar: yes}


  startLogout: -> 
    @executeSearch('')
    @setState {showBar: no}
  
  
  handleLogout: -> userActions.attemptLogout('')

  
  executeSearch: (searchTerm) -> searchActions.executeSearch(searchTerm)

  
  toggleMenu: ->
    {menuIsOpen, toggleMenu} = @props
    if menuIsOpen then toggleMenu()





module.exports = Search
