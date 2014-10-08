{Flux} = require 'delorean.js'
userAuth = require '../user_auth'


UserStore = Flux.createStore
  
  data: null
  isLoading: null
  rememberMe: window.localStorage.getItem('username')?
  username: window.localStorage.getItem('username') or ''
  password: ''

  actions:
    'user-login': 'setLoginData'
    'user-logout': 'logoutUser'
    'request-event': 'activeRequest'
    'update-fields': 'updateFieldData'


  initialize: ->
    @setLoginData(userAuth.isLoggedIn())

  setLoginData: (data) ->
    unless data? then return
    @data = {}
    @data.user = data
    @loginUser()
    @isLoading = false
    @emit 'change'


  getState: ->
    # Return the state
    {
      data: @data?.user or {}
      isLoading: @isLoading
      rememberMe: @rememberMe
      username: @username
      password: @password
      isLoggedIn: userAuth.isLoggedIn()?
    }


  updateFieldData: (data) ->
    {@username, @password, @rememberMe} = data
    unless @rememberMe then window.localStorage.removeItem('username')
    @emit 'change'


  activeRequest: (status) ->
    @isLoading = status
    @emit 'change'


  loginUser: ->
    window.localStorage.setItem('lastActivity', new Date().getTime())
    window.localStorage.setItem('user', JSON.stringify(@data.user))

  
  logoutUser: ->
    window.localStorage.removeItem 'lastActivity'
    window.localStorage.removeItem 'user'
    userAuth.logout()




module.exports = UserStore
