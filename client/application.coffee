React = require 'react'
Menu = require './menu'


Application = React.createClass
  
  displayName: 'Application'

  render: ->
    {div} = React.DOM
    {menuIsOpen} = @state

    div {
      className: 'container'
    }, [
      Menu {menuIsOpen}
      @props.activeRouteHandler {
        menuIsOpen
        toggleMenu: @toggleMenu
      }
    ]

  getInitialState: ->
    {
      menuIsOpen: no
    }

  toggleMenu: ->
    @setState {menuIsOpen: not @state.menuIsOpen}


module.exports = Application

