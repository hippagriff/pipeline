React = require 'react'
Spin = require 'spin'
_ = require 'lodash'


Spinner = React.createClass

  defaults:
    lines: 12 # The number of lines to draw
    length: 5 # The length of each line
    width: 3 # The line thickness
    radius: 8 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 0 # The rotation offset
    direction: 1 # 1: clockwise, -1: counterclockwise
    color: '#000000' # #rgb or #rrggbb or array of colors
    speed: 1 # Rounds per second
    trail: 60 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: false # Whether to use hardware acceleration
    className: 'spinner' # The CSS class to assign to the spinner
    zIndex: 15 # The z-index (defaults to 2000000000)


  displayName: 'spinner'


  render: ->
    {div} = React.DOM

    # Render the spinner
    div {
      ref: 'spinner'
      className: 'spinner-wrapper'
    }


  componentDidMount: ->
    # Extend the defaults into the props
    _.defaults(@props, @defaults)

    # Create a new spinner instance and start the spinning
    @spinner = new Spin(@props).spin()
    @refs.spinner.getDOMNode().appendChild(@spinner.el)


  stop: ->
    @spinner.stop()


module.exports = Spinner