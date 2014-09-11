React = require 'react'
{Flux} = require 'delorean.js'
Router = require 'react-router'
userActions = require '../actions/user'
user = require '../stores/user'


Login = React.createClass
  
  mixins: [Flux.mixins.storeListener]

  displayName: 'login'

  render: ->
    {div, button, input} = React.DOM

    console.log 'login render', @state

    (div {
      className: 'login'
    }, [
      input {
        type: 'text'
        ref: 'username'
        placeholder: 'username'
      }
      input {
        type: 'password'
        ref: 'password'
        placeholder: 'password'
      }
      button {
        onClick: @handleLogin
      }, ['login']
    ])


  handleLogin: (e) ->
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    userActions.attemptLogin(username, password)

  storeDidChange: ->
    if user.isLoggedIn()
      if user.requestedNav? then user.requestedNav.retry()
      else Router.replaceWith('/norm');

  getInitialState: ->
    console.log new Date().getTime()

    {}


module.exports = Login
