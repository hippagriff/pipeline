React = require 'react/addons'


LoginFields = React.createClass
  
  displayName: 'loginFields'

  render: ->
    {div, button, input} = React.DOM

    div {
        className: 'fields'
    }, [
      input {
        type: 'text'
        ref: 'username'
        placeholder: 'Username'
        onKeyPress: @handleLogin
        key: 'username'
      }
      input {
        type: 'password'
        ref: 'password'
        placeholder: 'Password'
        onKeyPress: @handleLogin
        key: 'password'
      }
      button {
        onClick: @handleLogin
        key: 'loginbutton'
      }, ['→']
    ]

  componentWillUnmount: ->
    @props.navOut()

  handleLogin: (e) ->
    if e.type is 'keypress' and e.key isnt 'Enter' then return
    username = @refs.username.getDOMNode().value
    password = @refs.password.getDOMNode().value
    @props.handleLogin(username, password)


module.exports = LoginFields
