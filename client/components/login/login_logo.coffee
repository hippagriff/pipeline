React = require 'react/addons'
animationMixin = require '../../mixins/animation_mixin'


LoginLogo = React.createClass
  
  displayName: 'loginLogo'

  mixins: [animationMixin]

  enterStateStart:
    left: -600
  enterStateEnd:
    left: 0
  enterEasing: 'easeOut'
  
  leaveStateStart:
    left: 0
  leaveStateEnd:
    left: -600
  leaveEasing: 'easeIn'

  render: ->
    {div} = React.DOM
    {left} = @state

    div {
      className: 'logo'
      key: 'logo'
      style:
        transform: "translate(#{left}px, 0) translateZ(0px)"
        "-webkit-transform": "translate(#{left}px, 0) translateZ(0px)"
        "-ms-transform": "translate(#{left}px, 0)"
    }, ['AegleCare']


module.exports = LoginLogo