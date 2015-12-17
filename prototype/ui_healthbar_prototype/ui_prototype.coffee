###
  Game ui prototype
###

class window.UIPrototype extends abstract.Object

  DT: "UIPrototype"

  constructor: (@gameLogic)->
    super

    console.log @DT, "Init."

    @container = $("#ui-prototype-container")
    @healthbar = @container.find "[health-bar]"

    @dataPlayer = @gameLogic.player.data

    $(@dataPlayer)
      .asEventStream(chms.ard.AbstractReactiveData.I_DATA_CHANGED)
      .filter((v)-> v.key == "currentHealth")
      .onValue @drawHealthbar

  drawHealthbar: =>
    console.log @DT, "Draw health bar"

    @healthbar.css width: @dataPlayer.getCurrentHealthInPercent() * 100 + "%"


