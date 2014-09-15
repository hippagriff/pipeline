React = require 'react'
authCheck = require '../mixins/authcheck'
userActions = require '../actions/user'


App = React.createClass

  mixins: [authCheck]
  
  render: ->
    {div, button} = React.DOM
    

    div {
      className: 'app-container'
      }, [
        button {
          onClick: @handleLogout
        }, ['logout']
      ]


  getInitialState: ->
    {

    }

  handleLogout: ->
    userActions.attemptLogout('')


module.exports = App
