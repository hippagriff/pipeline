React = require 'react'
authCheck = require '../mixins/authcheck'


App = React.createClass

  mixins: [authCheck]
  
  render: ->
    {div} = React.DOM
    

    (div {
      className: 'app-container'
      }, ['landing page'])


  getInitialState: ->
    {

    }


module.exports = App
