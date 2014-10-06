jest.dontMock('../login.coffee')
describe('Login', ->
  it('Login view', ->
    React = require 'react'
    TestUtils = React.TestUtils
    login = require '../login.coffee'


    expect(3).toBe(3)
  )
)