React = require 'react'
authCheck = require '../mixins/authcheck'
userActions = require '../actions/user'


App = React.createClass

  mixins: [authCheck]
  
  render: ->
    {div, ul, input, button} = React.DOM
    

    div {
      className: 'search-container'
    }, [
      div {
        className: 'search-bar'
      }, [
        input {
          ref:'searchField'
          className: 'search-input'
          type: 'search'
          placeholder: 'Search Patients'
        }, []
        button {
            className: 'search-logout-btn'
            onClick: @handleLogout
            title: 'Logout'
        }, ['⇥']
      ]
      ul {
        className: 'search-results-container'
      }, []
    ]


  getInitialState: -> {}

  componentDidMount: -> @refs.searchField.getDOMNode().focus()

  handleLogout: -> userActions.attemptLogout('')


module.exports = App
