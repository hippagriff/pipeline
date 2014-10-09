React = require 'react'
input = require('react-input-placeholder')(React)
animationMixin = require '../../mixins/animation_mixin'


SearchSimple = React.createClass
  
  displayName: 'searchSimple'

  mixins: [animationMixin]

  initialState:
    searchTerm: ''

  enterStateStart:
    left: 1600
  enterStateEnd:
    left: 0
  enterEasing: 'easeOut'
  
  leaveStateStart:
    left: 0
  leaveStateEnd:
    left: 1600
  leaveEasing: 'easeIn'


  render: ->
    {div, button} = React.DOM
    {searchTerm} = @state

    searchClearClass = 'search-clear'
    if searchTerm.length is 0 then searchClearClass += ' is-hidden'

    div {
      className: 'search-fields'
    }, [
      input {
        ref:'searchField'
        className: 'search-input'
        type: 'text'
        placeholder: 'Search Patients'
        key: 'searchField'
        onKeyUp: @executeSearch
      }
    ]

  
  componentDidEnter: -> @refs.searchField.getDOMNode().focus()


  # componentDidLeave: -> @props.handleLogout()


  executeSearch: (e) ->
    searchTerm = @refs.searchField.getDOMNode().value
    @props.executeSearch(searchTerm)
    @setState({searchTerm})

  
  handleLogout: (e) ->
    @props.handleLogout()

  
  clearSearch: (e) ->
    @refs.searchField.getDOMNode().value = ''
    @executeSearch(e)



module.exports = SearchSimple