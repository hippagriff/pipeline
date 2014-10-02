React = require 'react'
{Flux} = require 'delorean.js'
Spinner = require './spinner'
input = require('react-input-placeholder')(React)
animationMixin = require '../mixins/animation_mixin'


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
    if @state.stores.user.loading
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
      }
      input {
        className: 'password'
        type: 'password'
        ref: 'password'
        placeholder: 'Password'
        onKeyPress: @handleLogin
        key: 'password'
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
          onChange: @rememberUser
        }
        label {
          htmlFor: 'remember'
          key: 'remember-label'
        }, ['Remember Me']
      ]
    ]


  componentDidMount: (done) ->
    usernameField = @refs.username.getDOMNode()
    rememberMe = @refs.remember.getDOMNode()
    username = window.localStorage.getItem('username')

    if username?
      usernameField.value = username
      rememberMe.checked = true

  
  componentDidEnter: ->
    usernameField = @refs.username.getDOMNode()
    passwordField = @refs.password.getDOMNode()
    username = window.localStorage.getItem('username')

    if username? then passwordField.focus() else usernameField.focus()
    

  componentDidLeave: ->
    @props.navOut()


  handleLogin: (e) ->
    if e.type is 'keypress' and e.key isnt 'Enter' then return
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    @props.handleLogin(username, password)

    checked = @refs.remember.getDOMNode().checked
    if checked then window.localStorage.setItem('username', username)
    else window.localStorage.removeItem('username')



module.exports = LoginFields
