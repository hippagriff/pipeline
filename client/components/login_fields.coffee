React = require 'react/addons'
{Flux} = require 'delorean.js'
Spinner = require './spinner'


LoginFields = React.createClass
  
  displayName: 'loginFields'

  mixins: [Flux.mixins.storeListener]

  render: ->
    {div, button, input} = React.DOM

    console.log @state

    spinner = []
    if @state.stores.user.loading
      spinner.push(Spinner(
          color: 'rgb(255,255,255)'
        )
      )

    div {
        className: 'fields'
    }, [
      input {
        type: 'text'
        ref: 'username'
        placeholder: T 'Username'
        onKeyPress: @handleLogin
        key: 'username'
      }
      input {
        type: 'password'
        ref: 'password'
        placeholder: T 'Password'
        onKeyPress: @handleLogin
        key: 'password'
      }
      button {
        onClick: @handleLogin
        key: 'loginbutton'
      }, ['→']
      div { 
        className: "login-spinner"
      }, spinner
    ]

  componentWillUnmount: ->
    @props.navOut()


  handleLogin: (e) ->
    if e.type is 'keypress' and e.key isnt 'Enter' then return
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    @props.handleLogin(username, password)


module.exports = LoginFields
