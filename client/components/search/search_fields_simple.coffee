React = require 'react'
input = require('react-input-placeholder')(React)
animationMixin = require '../../mixins/animation_mixin'


SearchSimple = React.createClass
  
  displayName: 'searchSimple'

  mixins: [animationMixin]

  initialState:
    searchTerm: ''

  enterStateStart:
    top: -100
  enterStateEnd:
    top: 0
  enterEasing: 'easeOut'
  
  leaveStateStart:
    top: 0
  leaveStateEnd:
    top: -100
  leaveEasing: 'easeIn'


  render: ->
    {div, button} = React.DOM
    {searchTerm} = @state

    searchClearClass = 'search-clear'
    if searchTerm.length is 0 then searchClearClass += ' is-hidden'

    div {
      className: 'search-fields'
      style:
        top: @state.top
        transform: "translate(#{@state.top}px, 0) translateZ(0px)"
        "-webkit-transform": "translate(#{@state.top}px, 0) translateZ(0px)"
        "-ms-transform": "translate(#{@state.top}px, 0)"
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