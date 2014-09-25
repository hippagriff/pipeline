requestDispatcher = require '../dispatchers/server_request'


module.exports = class Request
  defaults:
    url: ''
    method: 'GET' 
    async: true
    timeout: 120000
    data: {} # Data to send to the server
    headers: null # Custom Headers
    success: null # Callback for success
    error: null # Callback for an error
    onTimeout: null # Callback for a timeout
    authenticate: on
    
  
  constructor: (@options) ->
    state = 'pending'
    # Set any unset properties to their options
    @options[k] = @defaults[k] for k,v of @defaults when @options[k] is undefined

    if @options.authenticate then {@authToken} = JSON.parse(window.localStorage.getItem('user'))

    @start()
  
  # Support for promise syntax
  # Will not support any true promise behavior
  done: (@doneCB) -> @
  then: (@thenCB) -> @
  error: (@errorCB) -> @  
  
  start: ->
    {method, data, headers, url, async, timeout, onTimeout, error, success, authenticate} = @options

    @requestEventChange(true)
          
    queryParam = if authenticate then "?authToken=#{@authToken}" else ''

    if method is "GET" then queryParam += "&#{k}=#{v}" for k,v of data
    
    # Create the request 
    xmlHttp = new XMLHttpRequest()
    xmlHttp.open(method, url + queryParam, async)
    
    # Headers
    xmlHttp.setRequestHeader "Content-type", "application/json"
    xmlHttp.setRequestHeader "Accept", "application/json, text/javascript, */*; q=0.01"

    for k,v of headers
      xmlHttp.setRequestHeader k, v
    
    # Watch for timeouts
    requestTimer = setTimeout ->
      xmlHttp.abort()
      @doneCB?("timeout", xmlHttp)
      onTimeout?()
    , timeout
    
    
    # Define the state change handler
    xmlHttp.onreadystatechange = =>
      # Request is complete
      if xmlHttp.readyState is 4
        clearTimeout requestTimer
        
        # Failed Request
        unless xmlHttp.status is 200
          error?(xmlHttp.status, xmlHttp)
          @errorCB?(xmlHttp.status, xmlHttp)
        # Successful request
        else 
          # Parse JSON
          try
            responseData = JSON.parse(xmlHttp.responseText)
          catch e
            console?.warn "Could not parse response from #{url}. Error says: #{e.message}"
            error?(xmlHttp.status, xmlHttp)
            @errorCB?(xmlHttp.status, xmlHttp)
            return
            
          # Run any supplied callback methods
          success?(responseData)
          @doneCB?(responseData)
          @thenCB?(responseData)

          @requestEventChange(false)

          
    # Send the request
    if method is 'PUT' or method is 'POST' then xmlHttp.send( JSON.stringify(data) )
    else xmlHttp.send()

    return @

  requestEventChange: (status) ->
    requestDispatcher.setStatus(status)
