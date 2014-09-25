React = require 'react'
domready = require 'detect-dom-ready'

routes = require './routes'

extractor = require 'ez-localize/extractor'

ezlocalize = require 'ez-localize'
localizations = require '../fixtures/data/localizations.json'

localizer = new ezlocalize.Localizer(localizations, "en") # Put language code here

# Make the localizations available throughout the app
localizer.makeGlobal()


domready ->
  document.body.innerHTML = ''
  React.renderComponent(routes, document.body)