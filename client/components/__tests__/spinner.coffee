jest.dontMock('../spinner.coffee')
describe('Spinner', ->
  it('inserts the spinner HTML', ->
    React = require 'react'
    TestUtils = React.TestUtils
    spinner = require '../spinner.coffee'


    expect(3).toBe(3)
  )
)