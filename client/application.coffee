React = require 'react'
Menu = require './menu'


Application = React.createClass
  
  displayName: 'Application'

  render: ->
    {div} = React.DOM

    console.log @props

    div {
      className: 'container'
    }, [
      Menu {}
      @props.activeRouteHandler {}
    ]

module.exports = Application

