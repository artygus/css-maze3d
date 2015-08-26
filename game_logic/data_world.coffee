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

    # {dataTypes.Matrix2d}
    @set "level", null

    # {dataTypes.Matrix2d} Entities position
    @set "entities", null