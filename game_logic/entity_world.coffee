###
  World entity
###

class gameLogic.entities.World extends gameLogic.Object

  DT: "gameLogic.entities.World"

  constructor: (@app)->
    super

    console.log @DT, "Init world."

    @data = new gameLogic.data.World()


  # Section: Level

  # Load given level into game
  # @param {Level} level
  load: (level)=>
    level = utils.serializers.Level.serializeObjectToWorldTree level
    @data.set "level", level



