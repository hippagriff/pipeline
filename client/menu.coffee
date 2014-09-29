React = require 'react'


Menu = React.createClass
  
  displayName: 'Menu'

  render: ->
    {div} = React.DOM

    className = 'menu'
    if @props.menuIsOpen then className += ' menu-open'

    div {
      className: className
    }, []


module.exports = Menu

