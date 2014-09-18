React = require 'react'
Router = require 'react-router'
moment = require 'moment'


PatientSearchResult = React.createClass
  
  displayName: 'patient-search-result'


  render: ->
    {div, span, li, br} = React.DOM

    {family, given} = @props.patient.name[0]
  
    fullName = ''
    fullName += "#{name}" for name in family
    fullName += ', '
    fullName += "#{name} " for name in given

    {value, label} = @props.patient.identifier[0]

    DOB = moment(@props.patient.birthDate, 'YYYY-MM-DD')
    console.log DOB
    YO = moment().diff(DOB, 'years')

    gender = @props.patient.gender.coding[0].display

    li {
      className: 'search-result-patient'
    }, [
      div {
        className: 'search-patient-picture'
      }
      div {
        className: 'search-patient-name'
      }, [fullName]
      div {
        className: 'search-patient-details'
      }, [
        "#{label}: #{value}"
        br {}
        "#{YO} YO, #{gender}"
      ]
    ]


module.exports = PatientSearchResult