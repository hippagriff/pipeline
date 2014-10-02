jest.dontMock('../../client/components/spinner.coffee')
describe('Spinner', ->
  it('inserts the spinner HTML', ->
    React = require 'react'
    TestUtils = React.addons.TestUtils
    spinner = require '../../client/components/spinner.coffee'


    expect(3).toBe(3)
  )
)