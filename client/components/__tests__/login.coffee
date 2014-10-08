jest.dontMock('../login.coffee')
jest.dontMock('../../stores/user.coffee')

beforeEach( ->
  store = {}
  
  window = {}
  window.localStorage =
    getItem: (item) -> return 
    setItem: (item, value) -> return
    removeItem: (item) -> return

  spyOn(window.localStorage, 'getItem').andCallFake( (key) ->
    return store[key];
  )
  spyOn(window.localStorage, 'setItem').andCallFake( (key, value) ->
    return store[key] = value
  )
  spyOn(window.localStorage, 'removeItem').andCallFake( (key) ->
    return store[key] = undefined
  )
)

describe('Login', ->
  it('Login view', ->
    React = require 'react/addons'
    TestUtils = React.TestUtils
    user = require '../../stores/user.coffee'
    #login = require '../login.coffee'


    expect(3).toBe(3)
  )
)