path = require 'path'
express = require 'express'
crypto = require 'crypto'
fs = require 'fs'
pkg = require '../package'
lessCompiler = require './route_handlers/less_compiler'


module.exports = (app, server) ->

  if app.get('env') isnt 'development' 
    # Load static files out of the 'build' directory in prod
    app.use('/', express['static'](path.join(__dirname, '../', 'build')))
  
  else 
    # Load static files out of the 'client' directory in dev
    app.use('/', express['static'](path.join(__dirname, '../', 'client')))
    
    # Less compiler
    app.get('/styles/:filename', lessCompiler)

  # Root route, render the app
  app.get('/', (req, res) ->
    res.render('index', { 
      title: pkg.name
      mode: app.get('env')
      timestamp: new Date().getTime()
    })
  )