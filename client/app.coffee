React = require 'react'


App = React.createClass
  
  render: ->
    {div} = React.DOM
    

    (div {
      className: 'app-container'
      }, ['landing page'])


  getInitialState: ->
    {

    }


module.exports = App
