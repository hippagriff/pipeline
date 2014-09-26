React = require 'react'


Menu = React.createClass
  
  displayName: 'Menu'

  render: ->
    {div} = React.DOM

    div {
      className: 'menu'
    }, []


module.exports = Menu

