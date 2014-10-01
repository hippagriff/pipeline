React = require 'react'
animationMixin = require '../mixins/animation_mixin'


LoginLogo = React.createClass
  
  displayName: 'loginLogo'

  mixins: [animationMixin]

  enterStateStart:
    left: -600
  enterStateEnd:
    left: 125
  enterEasing: 'easeOut'
  
  leaveStateStart:
    left: 125
  leaveStateEnd:
    left: -600
  leaveEasing: 'easeIn'

  render: ->
    {div} = React.DOM

    div {
      className: 'logo'
      key: 'logo'
      style:
        left: @state.left
    }, ['AegleCare']


module.exports = LoginLogo