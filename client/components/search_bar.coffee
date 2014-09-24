React = require 'react/addons'

SearchBar = React.createClass
  
  displayName: 'searchBar'

  render: ->
    {div, button, input} = React.DOM

    searchClearClass = 'search-clear'
    if @state.searchTerm.length is 0 then searchClearClass += ' is-hidden'

    div {
        className: 'bar'
    }, [
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
  }

  componentDidMount: -> 
    @refs.searchField.getDOMNode().focus()

  executeSearch: (e) ->
    searchTerm = @refs.searchField.getDOMNode().value
    @props.executeSearch(searchTerm)

  handleLogout: (e) ->
    @props.handleLogout()

  clearSearch: (e) ->
    @refs.searchField.getDOMNode().value = ''
    @props.executeSearch('');



module.exports = SearchBar