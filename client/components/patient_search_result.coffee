React = require 'react'
Router = require 'react-router'


PatientSearchResult = React.createClass
  
  displayName: 'patient-search-result'

  render: ->
    {div, li} = React.DOM

    li {
      className: 'search-result-patient'
    }, [@props.patient.name[0].given]


module.exports = PatientSearchResult