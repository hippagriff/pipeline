{Flux} = require 'delorean.js'
userAuth = require '../user_auth'
localStore = require '../utilities/local_storage'


UserStore = Flux.createStore
  
  data: null
  isLoading: null
  rememberMe: localStore.getItem('username')?
  username: localStore.getItem('username') or ''
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
    unless @rememberMe then localStore.removeItem('username')
    @emit 'change'


  activeRequest: (status) ->
    @isLoading = status
    @emit 'change'


  loginUser: ->
    localStore.setItem('lastActivity', new Date().getTime())
    localStore.setItem('user', JSON.stringify(@data.user))

  
  logoutUser: ->
    localStore.removeItem 'lastActivity'
    localStore.removeItem 'user'
    userAuth.logout()




module.exports = UserStore
