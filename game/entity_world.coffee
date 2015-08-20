###
  World entity
###

class game.entities.World extends game.Object

  DT: "game.entities.World"

  constructor: (@app)->
    super

    console.log @DT, "Init world."

    @data = new game.data.World()


  # Section: Level

  # Load given level into game
  # @param {Level} level
  load: (level)=>
    @data.set "level", level



