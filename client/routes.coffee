Router = require('react-router');
{Route, DefaultRoute, Routes, Link, NotFoundRoute} = Router

App = require './app'
TestPath = require './testpath'
Login = require './components/login'

module.exports = (
  Routes {}, [
    Route {
      path: 'start'
      handler: App
    }
    Route {
      path: 'test/:patientId'
      handler: TestPath
    }
    Route {
      path: 'login'
      handler: Login
    }
  ]

)