# Librarues
Router = require('react-router');
{Route, DefaultRoute, Routes, Link, NotFoundRoute, Redirect} = Router

# Component Route Hanlders
Search = require './components/search'
Login = require './components/login'

# Dispathers
userDispatcher = require './dispatchers/user'
searchDispatcher = require './dispatchers/patient_search'

module.exports = (
  Routes {}, [
    DefaultRoute {
      handler: Search
      key: 'defaultRoute'
      dispatcher: searchDispatcher
    }
    Route {
      path: 'login'
      handler: Login
      dispatcher: userDispatcher
      key: 'login'
    }
    Route {
      path: 'search'
      handler: Search
      dispatcher: searchDispatcher
      key: 'search'
    }
  ]
)