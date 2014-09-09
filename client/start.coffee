React = require 'react'
domready = require 'detect-dom-ready'

routes = require './routes'


domready ->
  #document.body.innerHTML = ''
  #console.log App

  React.renderComponent(routes, document.body)