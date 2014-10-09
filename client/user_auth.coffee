localStore = require './utilities/local_storage'

module.exports =

  userData: null

  isLoggedIn: ->
    if @userData? then return @userData

    storedUser = localStore.getItem('user')
    if storedUser? and not @isTimedOut()
      @userData = JSON.parse(storedUser)
      return @userData
    else
      return null


  isTimedOut: ->
    lastActivity = localStore.getItem('lastActivity')
    unless lastActivity? then return yes
    
    now = new Date().getTime()

    if now - lastActivity < 1000 * 60 * 30 then return no
    else return yes

  logout: ->
    @userData = null
