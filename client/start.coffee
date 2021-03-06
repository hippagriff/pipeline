React = require 'react/addons'
domready = require 'detect-dom-ready'

routes = require './routes'

ezlocalize = require 'ez-localize'
localizations = require './strings/localizations.json'

localizer = new ezlocalize.Localizer(localizations, "en") # Put language code here

# Make the localizations available throughout the app
localizer.makeGlobal()


domready ->
  document.body.innerHTML = ''
  React.renderComponent(routes, document.body)