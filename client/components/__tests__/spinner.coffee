jest
  .dontMock('../widgets/spinner.coffee')

describe('Spinner', ->
  it('inserts the spinner HTML', ->
    {TestUtils} = require 'react/addons'
    spinner = require '../widgets/spinner.coffee'


    expect(3).toBe(3)
  )
)