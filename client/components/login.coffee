# Libs
React = require 'react'
{TransitionGroup} = React.addons
{Flux} = require 'delorean.js'
Router = require 'react-router'

# Actions
userActions = require '../actions/user'


# Components
LoginFields = require './login_fields'
LoginLogo = require './login_logo'


Login = React.createClass
  
  mixins: [Flux.mixins.storeListener]

  statics:
    requestedNav: null

  displayName: 'login'

  render: ->
    {div, button, input, ul, li} = React.DOM

    
    logo = []
    fields = []
    if @state.showForm and not @state.stores.user.isLoggedIn
      logo.push(LoginLogo {key: 'logo'})

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
        TransitionGroup {
          transitionName: 'logo'
          key: 'logoTrans'
        }, logo
        TransitionGroup {
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

  componentWillMount: -> @checkLoginStatus()

  getInitialState: -> {showForm: no}

  componentDidMount: -> @setState({showForm: yes})

  handleLogin: (username, password) -> userActions.attemptLogin(username, password)

  checkLoginStatus: -> 
    if @state.stores.user.isLoggedIn
      @setState({showForm: no})
      @navOut()

  navOut: ->
    if Login.requestedNav?
      requestedNav = Login.requestedNav
      Login.requestedNav = null
      requestedNav.retry()
    else
      Router.replaceWith '/search'



module.exports = Login
