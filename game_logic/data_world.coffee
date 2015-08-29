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

    # {dataTypes.EntityMatrix2d} Actors position
    @set "actors", null