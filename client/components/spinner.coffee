Spin = require 'spin'


module.exports = class Spinner

  defaults:
    lines: 13 # The number of lines to draw
    length: 20 # The length of each line
    width: 10 # The line thickness
    radius: 30 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 0 # The rotation offset
    direction: 1 # 1: clockwise, -1: counterclockwise
    color: '#000' # #rgb or #rrggbb or array of colors
    speed: 0.7 # Rounds per second
    trail: 60 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: false # Whether to use hardware acceleration
    className: 'spinner' # The CSS class to assign to the spinner
    zIndex: 10 # The z-index (defaults to 2000000000)
    top: '50%' # Top position relative to parent
    left: '50%' # Left position relative to parent


  constructor: (@options) ->
    # Set any unset properties to their options
    @options[k] = @defaults[k] for k, v of @defaults when @options[k] is undefined
    
    # Create a new spinner instance
    return new Spin(@options).spin().el