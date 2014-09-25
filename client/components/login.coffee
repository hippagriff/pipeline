React = require 'react/addons'
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup
{Flux} = require 'delorean.js'
Router = require 'react-router'

LoginFields = require './login_fields'

userActions = require '../actions/user'
user = require '../stores/user'


Login = React.createClass
  
  mixins: [Flux.mixins.storeListener]

  displayName: 'login'

  render: ->
    {div, button, input, ul, li} = React.DOM

    
    logo = []
    fields = []
    if @state.showForm and not @state.stores.user.isLoggedIn
      logo.push div {
        className: 'logo'
        key: 'logo'
      }, ['AegleCare']

      fields.push LoginFields {
        handleLogin: @handleLogin
        navOut: @navOut
        key: 'fields'
      }, []
    
    
    div {
      className: 'login-container'
      id: 'login'
      key: 'login-container'
    }, [
      div {
        className: 'form-container'
        key: 'form-container'
      }, [
        ReactCSSTransitionGroup {
          transitionName: 'logo'
          key: 'logoTrans'
        }, logo
        ReactCSSTransitionGroup {
          transitionName: 'fields'
          key: 'fieldsTrans'
        }, fields
      ]
      ul {
        className: 'footer'
      }, [
        li {}, ['Forgot Username/Password?']
        li {}, ['Privacy Policy']
        li {}, ["Copyright © #{new Date().getYear()} AegleCare, Inc"]
      ]
    ]

  getInitialState: -> {showForm: no}

  componentDidMount: -> @setState({showForm: yes})

  handleLogin: (username, password) -> userActions.attemptLogin(username, password)

  checkLoginStatus: -> if @state.stores.user.isLoggedIn then @setState({showForm: no})

  navOut: ->
    if user.store.requestedNav? then user.store.requestedNav.retry()
    else Router.replaceWith '/search'



module.exports = Login
