# Libraries
Router = require('react-router');
{Route, DefaultRoute, Routes, Link, NotFoundRoute, Redirect} = Router

# Component Route Handlers
Application = require './application'
Search = require './components/search'
Login = require './components/login'

# Dispatchers
userDispatcher = require './dispatchers/user'
searchDispatcher = require './dispatchers/patient_search'

module.exports = (
  Routes {
    location: 'history'
  }, [
    Route {
      path: '/'
      handler: Application
      key: 'application'
    }, [
      Route {
        name: 'search'
        path: 'search'
        handler: Search
        dispatcher: searchDispatcher
        key: 'search'
      }
      DefaultRoute {
        handler: Search
        dispatcher: searchDispatcher
        key: 'DefaultRouteSeaech'
      }
    ]
    Route {
      path: 'login'
      handler: Login
      dispatcher: userDispatcher
      key: 'login'
    }
  ]
)