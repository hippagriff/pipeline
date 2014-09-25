React = require 'react'
Router = require 'react-router'
moment = require 'moment'


PatientSearchResult = React.createClass
  
  displayName: 'patient-search-result'


  render: ->
    {div, span, li, br} = React.DOM

    {firstName, lastName, middleName, dateOfBirth, mrn, gender} = @props.patient
  
    fullName = "#{lastName}, #{firstName}"
    if middleName? and middleName isnt '' then fullName += " #{middleName}"


    DOB = moment(dateOfBirth).utc()
    YO = moment().utc().diff(DOB, 'years')

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
        "mrn: #{mrn}"
        br {}
        "#{YO} YO, #{gender}"
      ]
    ]


module.exports = PatientSearchResult