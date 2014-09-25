# Libraries
Router = require('react-router');
{Route, DefaultRoute, Routes, Link, NotFoundRoute, Redirect} = Router

# Component Route Handlers
Search = require './components/search'
Login = require './components/login'

# Dispatchers
userDispatcher = require './dispatchers/user'
searchDispatcher = require './dispatchers/patient_search'

module.exports = (
  Routes {}, [
    DefaultRoute {
      handler: Search
    }
    Route {
      path: 'login'
      handler: Login
      dispatcher: userDispatcher
    }
    Route {
      path: 'search'
      handler: Search
      dispatcher: searchDispatcher
    }
  ]
)