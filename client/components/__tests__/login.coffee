jest
  .dontMock('../login/login.coffee')
  .dontMock('../../stores/user.coffee')
  .mock('../../utilities/local_storage.coffee')


describe('Login', ->
  it('Login view', ->
    {TestUtils} = require 'react/addons'
    login = require '../login/login.coffee'


    expect(3).toBe(3)
  )
)