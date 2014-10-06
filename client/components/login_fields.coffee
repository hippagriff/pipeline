React = require 'react'
{Flux} = require 'delorean.js'
Spinner = require './spinner'
input = require('react-input-placeholder')(React)
animationMixin = require '../mixins/animation_mixin'

userActions = require '../actions/user'


LoginFields = React.createClass
  
  displayName: 'loginFields'

  mixins: [Flux.mixins.storeListener, animationMixin]

  enterStateStart:
    left: 1600
  enterStateEnd:
    left: 125
  enterEasing: 'easeOut'
  
  leaveStateStart:
    left: 125
  leaveStateEnd:
    left: 1600
  leaveEasing: 'easeIn'

  render: ->
    {div, button, label} = React.DOM
    {left} = @state

    spinner = []
    if @state.stores.user.isLoading
      spinner.push(Spinner(
          color: 'rgb(255,255,255)'
          key: 'spinner-container'
        )
      )


    div {
        className: 'fields'
        style:
          transform: "translate(#{left}px, 0) translateZ(0px)"
          "-webkit-transform": "translate(#{left}px, 0) translateZ(0px)"
          "-ms-transform": "translate(#{left}px, 0)"
    }, [
      input {
        className: 'username'
        type: 'text'
        ref: 'username'
        placeholder: 'Username'
        onKeyPress: @handleLogin
        key: 'username'
        value: @state.stores.user.username
        onChange: @updateFields
      }
      input {
        className: 'password'
        type: 'password'
        ref: 'password'
        placeholder: 'Password'
        onKeyPress: @handleLogin
        key: 'password'
        value: @state.stores.user.password
        onChange: @updateFields
      }
      button {
        className: 'login-btn'
        onClick: @handleLogin
        key: 'loginbutton'
      }, ['→']
      div { 
        className: "login-spinner"
        key: 'spinner'
      }, spinner
      div {
        className: 'remember-me'
        key: 'remember'
      }, [
        input {
          type: 'checkbox'
          ref: 'remember'
          id: 'remember'
          key: 'remember-check'
          onChange: @updateFields
          checked: @state.stores.user.rememberMe
        }
        label {
          htmlFor: 'remember'
          key: 'remember-label'
        }, ['Remember Me']
      ]
    ]

  
  componentDidEnter: ->
    usernameField = @refs.username.getDOMNode()
    passwordField = @refs.password.getDOMNode()
    username = window.localStorage.getItem('username')

    if username? then passwordField.focus() else usernameField.focus()
    

  componentDidLeave: ->
    @props.navOut()


  updateFields: ->
    userActions.updateFieldData(
      username: @refs.username.getDOMNode().value
      password: @refs.password.getDOMNode().value
      rememberMe: @refs.remember.getDOMNode().checked
    )
    

  handleLogin: (e) ->
    if e.type is 'keypress' and e.key isnt 'Enter' then return
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    @props.handleLogin(username, password)

    checked = @refs.remember.getDOMNode().checked
    if checked then window.localStorage.setItem('username', username)
    else window.localStorage.removeItem('username')



module.exports = LoginFields
