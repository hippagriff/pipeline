{Flux} = require 'delorean.js'

User = Flux.createStore
  
  data: null
  requestedNav: null

  setLoginData: (data) ->
    @data = {}
    @data.user = data
    @loginUser()
    @emit 'change'
  

  actions:
    'user-login': 'setLoginData'
    'user-logout': 'logoutUser'


  getState: ->
    {
      user: @data?.user or {}
    }

  
  isLoggedIn: ->
    # If there is no user data, check for it in localStorage
    if @data is null
      user = window.localStorage.getItem('user')
      if user? and not @isTimedOut()
        @setLoginData(JSON.parse(user))
        return yes
      else
        return no
    # If there is user data, check for a timeout
    else if @data?.user?
      unless @isTimedOut() then return yes
      else return no
    # Otherwsie, the user is not logged in
    else
      return no

  
  isTimedOut: ->
    lastActivity = window.localStorage.getItem('lastActivity')
    unless lastActivity? then return yes
    
    now = new Date().getTime()

    if now - lastActivity < 1000 * 60 * 30 then return no
    else return yes


  loginUser: ->
    window.localStorage.setItem('lastActivity', new Date().getTime())
    window.localStorage.setItem('user', JSON.stringify(@data.user))

  
  logoutUser: ->
    window.localStorage.removeItem 'lastActivity'
    window.localStorage.removeItem 'user'


module.exports = new User()