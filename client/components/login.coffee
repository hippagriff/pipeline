# Libs
React = require 'react'
{Flux} = require 'delorean.js'
Router = require 'react-router'

# Actions
userActions = require '../actions/user'

# Stores
user = require '../stores/user'
request = require '../stores/server_request'

# Components
Spinner = require './spinner'


Login = React.createClass
  
  mixins: [Flux.mixins.storeListener]

  displayName: 'login'

  render: ->
    {div, button, input} = React.DOM

    
    div {
      className: 'login'
    }, [
      div { 
        id: "test1"
        ref: "test1" 
      }
      div {
        className: 'login-form '
      }, [
        input {
          type: 'text'
          ref: 'username'
          placeholder: 'Username'
          onKeyPress: @handleLogin
        }
        input {
          type: 'password'
          ref: 'password'
          placeholder: 'Password'
          onKeyPress: @handleLogin
        }
        button {
          onClick: @handleLogin
        }, ['→']
      ]
    ]

  #componentWillMount: -> do @checkLoginStatus

  componentDidMount: -> 
    container = document.getElementById('test1')
    spinner = new Spinner(
      color: '#336699'
    )

    request.onChange ->
      if request.store.data.loading then React.renderComponent(spinner, container)
      else React.unmountComponentAtNode(container)


  componentDidUpdate: -> do @checkLoginStatus


  handleLogin: (e) ->
    if e.type is 'keypress' and e.key isnt 'Enter' then return
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    userActions.attemptLogin(username, password)

  checkLoginStatus: ->
    if @state.stores.user.isLoggedIn
      if user.store.requestedNav? then user.store.requestedNav.retry()
      else Router.replaceWith '/search'



module.exports = Login
