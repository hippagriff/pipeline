Animation = require 'ainojs-animation'
easing = require 'ainojs-easing'
_ = require 'lodash'

###
  Purpose: Easily add Enter and Leave animations to a React Component (that is a child of ReactTransitionGroup)
  
  The react compnent must have these properties for an Enter Animation
  
  ENTER ANIMATION PROPS
  enterDuration: number (millisecoinds)
  enterStateStart: object
  enterStateEnd: object
  enterEasing: string (ainojs-easing function name: https://github.com/aino/ainojs-easing)
  
  LEAVE ANIMATION PROPS
  leaveDuration: number (millisecoinds)
  leaveStateStart: object
  leaveStateEnd: object
  leaveEasing: string (ainojs-easing function name: https://github.com/aino/ainojs-easing)


###

module.exports =
  getInitialState: ->
    @enterStateStart

  componentWillEnter: (done) ->
    animation = new Animation {
        duration: @enterDuration or 300
        easing: easing(@enterEasing or 'linear')
    }

    stateStart = _.clone(@enterStateStart)
    
    animation.init stateStart
    animation.on('frame', @onFrame)
    animation.on('complete', done)

    animation.animateTo @enterStateEnd


  componentWillLeave: (done) ->
    animation = new Animation {
        duration: @leaveDuration or 300
        easing: easing(@leaveEasing or 'linear')
    }

    stateStart = _.clone(@leaveStateStart)

    animation.init stateStart
    animation.on('frame', @onFrame)
    animation.on('complete', done)

    animation.animateTo @leaveStateEnd

  onFrame: (e) ->
    @setState e.values