patientData = require './data/patients'
_ = require 'lodash'

module.exports = (req, res) ->
  {term, firstName, lastName, dateOfBirth, mrn} = req.query

  # No input
  if not term and not firstName and not lastName and not dateOfBirth and not mrn then res.json([])

  # Simple search
  if not firstName and not lastName and not dateOfBirth and not mrn    
    term = term.toLowerCase()

    results = []
    results.push(patient) for patient in patientData when patient.firstName.toLowerCase().search(term) isnt -1 or patient.lastName.toLowerCase().search(term) isnt -1
      
    res.json(results)

  # Fixed search
  else if not term
    fixedTerms =
      firstName: firstName.toLowerCase().trim()
      lastName: lastName.toLowerCase().trim()
      dateOfBirth: dateOfBirth.toLowerCase().trim()
      mrn: mrn.toLowerCase().trim()

    # Trim out the invalid terms
    terms = {}
    for criteria, term of fixedTerms
      if term
        # term = term.trim().toLowerCase()
        terms[criteria] = term

    # Search against the valid terms, then push the results
    results = []
  
    for patient in patientData
      isMatch = no

      for criteria, term of terms
        if patient[criteria]?.toLowerCase().search(term) isnt -1
          isMatch = yes
        else 
          isMatch = no
          break

      if isMatch then results.push(patient) 

    res.json(results)