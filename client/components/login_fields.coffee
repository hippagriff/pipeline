React = require 'react/addons'
{Flux} = require 'delorean.js'
Spinner = require './spinner'


LoginFields = React.createClass
  
  displayName: 'loginFields'

  mixins: [Flux.mixins.storeListener]

  render: ->
    {div, button, input, label} = React.DOM

    spinner = []
    if @state.stores.user.loading
      spinner.push(Spinner(
          color: 'rgb(255,255,255)'
          key: 'spinner-container'
        )
      )

    div {
        className: 'fields'
    }, [
      input {
        className: 'username'
        type: 'text'
        ref: 'username'
        placeholder: T 'Username'
        onKeyPress: @handleLogin
        key: 'username'
      }
      input {
        className: 'password'
        type: 'password'
        ref: 'password'
        placeholder: T 'Password'
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

  componentWillUnmount: ->
    @props.navOut()

  componentDidMount: ->
    usernameField = @refs.username.getDOMNode()
    rememberMe = @refs.remember.getDOMNode()
    passwordField = @refs.password.getDOMNode()
    username = window.localStorage.getItem('username')

    setTimeout ->
      usernameField.focus()
      if username?
        usernameField.value = username
        rememberMe.checked = true
        passwordField.focus()
    , 350


  handleLogin: (e) ->
    if e.type is 'keypress' and e.key isnt 'Enter' then return
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    @props.handleLogin(username, password)

    checked = @refs.remember.getDOMNode().checked
    if checked then window.localStorage.setItem('username', username)
    else window.localStorage.removeItem('username')



module.exports = LoginFields
