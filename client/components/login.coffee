React = require 'react'
Router = require 'react-router'
user = require '../stores/user'


Login = React.createClass
  
  displayName: 'login'

  render: ->
    {div, button} = React.DOM

    (div {
      className: 'login'
    }, [
      (button {
        onClick: @handleLogin
      }, ['login'])
    ])


  handleLogin: (e) ->
    user.loggedIn = yes

    if user.attemptedTransition?
      transition = user.attemptedTransition
      user.attemptedTransition = null
      transition.retry()
    else
      Router.replaceWith '/start'


module.exports = Login
