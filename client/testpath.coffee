React = require 'react'
authCheck = require './mixins/authcheck'

Testpath = React.createClass

  mixins: [authCheck]
  
  render: ->
    {div} = React.DOM
    

    (div {
      className: 'test-path'
      }, ["PID: #{@props.params.patientId}"])



module.exports = Testpath
