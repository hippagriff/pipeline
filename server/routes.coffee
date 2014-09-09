path = require 'path'
express = require 'express'
crypto = require 'crypto'
fs = require 'fs'
pkg = require '../package'


module.exports = (app, server) ->

  if app.get('env') isnt 'development' 
    app.use('/', express['static'](path.join(__dirname, '../', 'build')))
  
  else 
    app.use('/', express['static'](path.join(__dirname, '../', 'client')))

  # Root route, render the app
  app.get('/', (req, res) ->
    res.render('index', { 
      title: pkg.name
      mode: app.get('env')
      timestamp: new Date().getTime()
    })
  )