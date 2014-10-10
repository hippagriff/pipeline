React = require 'react'
input = require('react-input-placeholder')(React)
animationMixin = require '../../mixins/animation_mixin'


SearchFixed = React.createClass
  
  displayName: 'searchFixed'

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
        top: @state.top
        opacity: @state.opacity
        transform: "scale(#{@state.scale})"
        "-webkit-transform": "scale(#{@state.scale})"
        "-ms-transform": "scale(#{@state.scale})"
    }, [
      input {
        ref: 'lastname'
        className: 'search-fixed-lastname'
        type: 'text'
        placeholder: 'Last Name'
        key: 'lastname'
        onKeyUp: @executeSearch
      }
      input {
        ref: 'firstname'
        className: 'search-fixed-firstname'
        type: 'text'
        placeholder: 'First Name'
        key: 'firstname'
        onKeyUp: @executeSearch
      }
      input {
        ref: 'dob'
        className: 'search-fixed-dob'
        type: 'text'
        placeholder: 'DOB'
        key: 'dob'
        onKeyUp: @executeSearch
      }
      input {
        ref: 'mrn'
        className: 'search-fixed-mrn'
        type: 'text'
        placeholder: 'MRN'
        key: 'mrn'
        onKeyUp: @executeSearch
      }
    ]

  
  componentDidEnter: -> @refs.firstname.getDOMNode().focus()


  # componentDidLeave: -> @props.handleLogout()


  executeSearch: (e) ->
    # @props.executeSearch(searchTerm)
    @setState(
      firstname: @refs.firstname.getDOMNode().value
      lastname: @refs.lastname.getDOMNode().value
      dob: @refs.dob.getDOMNode().value
      mrn: @refs.mrn.getDOMNode().value
    )

  
  handleLogout: (e) ->
    @props.handleLogout()

  
  clearSearch: (e) ->
    @refs.firstname.getDOMNode().value = ''
    @refs.lastname.getDOMNode().value = ''
    @refs.dob.getDOMNode().value = ''
    @refs.mrn.getDOMNode().value = ''
    @executeSearch(e)



module.exports = SearchFixed