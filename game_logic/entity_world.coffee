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
    @data.set "level", dataTypes.Matrix2d.createFromLevelObject(level)
    @data.set "entities", new dataTypes.Matrix2d()

    # Set player to initial position
    # TODO: debug
    icell = @data.get("level").getFlatCellCoords()[0]
    @data.get("entities").putData icell, @app.player




