React = require 'react'
input = require('react-input-placeholder')(React)
animationMixin = require '../../mixins/animation_mixin'


SearchBar = React.createClass
  
  displayName: 'SearchBar'

  mixins: [animationMixin]

  initialState:
    searchTerm: ''

  enterStateStart:
    top: -51
  enterStateEnd:
    top: 0
  enterEasing: 'easeOut'

  leaveStateStart:
    top: 0
  leaveStateEnd:
    top: -51
  leaveEasing: 'easeIn'

  render: ->
    {div, button} = React.DOM
    {searchTerm, top} = @state

    searchClearClass = 'search-clear'
    if searchTerm.length is 0 then searchClearClass += ' is-hidden'

    div {
      className: 'bar'
      style:
        transform: "translate(0, #{top}px) translateZ(0px)"
        "-webkit-transform": "translate(translate(0, #{top}px) translateZ(0px)"
        "-ms-transform": "translate(translate(0, #{top}px)"
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
          onClick: @props.startLogout
      }, ['⇥']
    ]

  
  componentDidEnter: -> @refs.searchField.getDOMNode().focus()


  componentDidLeave: -> @props.handleLogout()


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