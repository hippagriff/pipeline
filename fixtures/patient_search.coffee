patientData = require './data/patients'
_ = require 'lodash'

module.exports = (req, res) ->
  {term} = req.query

  if not term? then res.status(400).end()
  
  term = term.toLowerCase()

  results = []

  for patient in patientData
    name = _.findWhere(patient.name, {use: 'official'})

    unless name? then continue

    for given in name.given
      givenMatch = no
      if given.toLowerCase().search(term) isnt -1
        results.push(patient)
        givenMatch = yes
        break

    if givenMatch then continue

    for family in name.family
      familyMatch = no
      if family.toLowerCase().search(term) isnt -1
        results.push(patient)
        familyMatch = yes
        break

    if familyMatch then continue

  res.json(results)