###
  World data
###

class gameLogic.data.World extends chms.ard.AbstractReactiveData

  DT: "gameLogic.data.World"

  constructor: ->
    super

    console.log @DT, "Init."

  init: =>
    super

    @set "level", null