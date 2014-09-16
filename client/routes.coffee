# Librarues
Router = require('react-router');
{Route, DefaultRoute, Routes, Link, NotFoundRoute, Redirect} = Router

# Component Route Hanlders
Search = require './components/search'
Login = require './components/login'

# Dispathers
userDispatcher = require './dispatchers/user'


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