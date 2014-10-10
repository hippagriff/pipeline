React = require 'react/addons'
input = require('react-input-placeholder')(React)
{TransitionGroup} = React.addons
animationMixin = require '../../mixins/animation_mixin'

SearchSimple =  require './search_fields_simple'
SearchFixed = require './search_fields_fixed'


SearchBar = React.createClass
  
  displayName: 'SearchBar'

  mixins: [animationMixin]

  initialState:
    searchTerm: ''
    fixedSearch: false

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
    {searchTerm, fixedSearch, top} = @state

    searchClearClass = 'search-clear'
    if searchTerm.length is 0 then searchClearClass += ' is-hidden'

    searchToggleClass = 'search-simple'

    if fixedSearch
      # Use the fixed search
      searchToggleClass = 'search-fixed'
      searchFields = []
      searchFields.push(SearchFixed {
          key: 'searchFixed'
        }
      )
    else
      # Use the simple search
      searchToggleClass = 'search-simple'
      searchFields = []
      searchFields.push(SearchSimple {
          key: 'searchSimple'
        }
      )

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
      }, []
      TransitionGroup {
        className: 'search-container'
        transitionName: 'searchContainer'
        key: 'searchContainer'
      }, searchFields
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
      button {
        className: "search-toggle #{searchToggleClass}"
        title: 'Search toggle'
        key: 'searchToggle'
        onClick: @searchToggle
      }, []
    ]

  


  componentDidLeave: -> @props.handleLogout()


  searchToggle: -> @setState({ fixedSearch: not @state.fixedSearch })

  
  handleLogout: (e) ->
    @props.handleLogout()




module.exports = SearchBar