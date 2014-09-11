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


  getState: ->
    {
      user: @data?.user or {}
      isLoggedIn: @isLoggedIn()
    }

  
  isLoggedIn: () ->
    if @data is null
      user = window.localStorage.getItem('user')
      if user? and not @isTimedOut()
        @data = {}
        @data.user = JSON.parse(user)
        @loginUser()
        return yes
      else
        return no
    else if @data?.user?
      unless @isTimedOut() then return yes
      else return no
    else
      return no

  
  isTimedOut: ->
    unless window.localStorage.getItem('lastActivity')? then return yes
    
    lastActivity = window.localStorage.getItem('lastActivity')
    now = new Date().getTime()

    if now - lastActivity < 1000 * 60 * 30 then return no
    else return yes


  loginUser: () ->
    window.localStorage.setItem('lastActivity', new Date().getTime())
    window.localStorage.setItem('user', JSON.stringify(@data.user))


module.exports = new User()