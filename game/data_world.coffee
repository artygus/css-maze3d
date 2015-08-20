###
  World data
###

class game.data.World extends chms.ard.AbstractReactiveData

  DT: "game.data.World"

  constructor: ->
    super

    console.log @DT, "Init."

  init: =>
    super

    @set "level", null