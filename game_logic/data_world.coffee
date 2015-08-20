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

    # {Object}
    @set "level", null