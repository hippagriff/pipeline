React = require 'react'
input = require('react-input-placeholder')(React)

SearchBar = React.createClass
  
  displayName: 'searchBar'

  render: ->
    {div, button} = React.DOM

    searchClearClass = 'search-clear'
    if @state.searchTerm.length is 0 then searchClearClass += ' is-hidden'

    className = 'bar'
    if @state.showBar then className += ' is-visible'

    div {
        className: className
    }, [
      button {
        className: 'off-canvas-btn'
        key: 'off-canvas-btn'
        title: 'Show Menu'
        onClick: @props.toggleMenu
      }
      input {
        ref:'searchField'
        className: 'search-input'
        type: 'text'
        placeholder: 'Search Patients'
        key: 'searchField'
        onKeyUp: @executeSearch
      }, []
      button {
        className: searchClearClass
        title: 'Clear Search'
        key: 'searcClearBtn'
        onClick: @clearSearch
      }, []
      button {
          className: 'logout-btn'
          title: 'Logout'
          key: 'logoutBtn'
          onClick: @handleLogout
      }, ['⇥']
    ]

  getInitialState: -> {
    searchTerm: ''
    showBar: no
  }

  componentDidMount: -> 
    @refs.searchField.getDOMNode().focus()

    @setState({showBar: yes})


  executeSearch: (e) ->
    searchTerm = @refs.searchField.getDOMNode().value
    @props.executeSearch(searchTerm)
    @setState({searchTerm})

  handleLogout: (e) ->
    @props.handleLogout()

  clearSearch: (e) ->
    @refs.searchField.getDOMNode().value = ''
    @executeSearch(e)



module.exports = SearchBar