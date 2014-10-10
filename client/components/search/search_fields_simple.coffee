React = require 'react'
input = require('react-input-placeholder')(React)
animationMixin = require '../../mixins/animation_mixin'


SearchSimple = React.createClass
  
  displayName: 'searchSimple'

  mixins: [animationMixin]

  initialState:
    searchTerm: ''

  enterStateStart:
    opacity: 0
    scale: 0
  enterStateEnd:
    opacity: 1
    scale: 1
  enterEasing: 'easeOut'
  
  leaveStateStart:
    opacity: 1
    scale: 1
  leaveStateEnd:
    opacity: 0
    scale: 0
  leaveEasing: 'easeIn'


  render: ->
    {div, button} = React.DOM
    {searchTerm} = @state

    searchClearClass = 'search-clear'
    if searchTerm.length is 0 then searchClearClass += ' is-hidden'

    div {
      className: 'search-fields'
      style:
        width: @state.width
        opacity: @state.opacity
        transform: "scale(#{@state.scale})"
        "-webkit-transform": "scale(#{@state.scale})"
        "-ms-transform": "scale(#{@state.scale})"
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