patientData = require './data/patients'
_ = require 'lodash'

module.exports = (req, res) ->
  {term} = req.query

  if not term? then res.status(400).end()
  
  term = term.toLowerCase()

  results = []
  results.push(patient) for patient in patientData when patient.firstName.toLowerCase().search(term) isnt -1 or patient.lastName.toLowerCase().search(term) isnt -1
    
  res.json(results)