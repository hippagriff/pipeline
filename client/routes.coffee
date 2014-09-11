Router = require('react-router');
userDispatcher = require './dispatchers/user'
{Route, DefaultRoute, Routes, Link, NotFoundRoute, Redirect} = Router

Search = require './components/search'
Login = require './components/login'

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
    }
  ]
)