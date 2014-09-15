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

    
    div {
      className: 'login'
    }, [
      div {
        className: 'login-form '
      }, [
        input {
          type: 'text'
          ref: 'username'
          placeholder: 'Username'
        }
        input {
          type: 'password'
          ref: 'password'
          placeholder: 'Password'
        }
        button {
          onClick: @handleLogin
        }, ['Continue']
      ]
    ]

  componentWillMount: ->
    @checkLoginStatus()

  handleLogin: (e) ->
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    userActions.attemptLogin(username, password)

  storeDidChange: ->
    @checkLoginStatus()

  checkLoginStatus: ->
    if user.store.isLoggedIn()
      if user.requestedNav? then user.requestedNav.retry()
      else Router.replaceWith '/search'

  getInitialState: ->
    console.log new Date().getTime()

    {}


module.exports = Login
