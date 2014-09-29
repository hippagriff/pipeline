# Libs
React = require 'react/addons'
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup
{Flux} = require 'delorean.js'
Router = require 'react-router'

# Actions
userActions = require '../actions/user'

# Stores
user = require '../stores/user'

# Components
LoginFields = require './login_fields'


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
        key: 'footer'
      }, [
        li {key: 'forgot'}, ['Forgot Username/Password?']
        li {key: 'privacy'}, ['Privacy Policy']
        li {key: 'copyright'}, ["Copyright © #{new Date().getFullYear()} AegleCare, Inc"]
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
