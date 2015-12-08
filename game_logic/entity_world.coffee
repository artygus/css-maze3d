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
    @data.set "actors", new dataTypes.EntityMatrix2d()

  # Section: actors positioning

  @E_NON_EMPTY_CELL: new Error("You are trying perform action on non empty cell!")

  @E_EMPTY_CELL: new Error("You are trying permorm action on empty cell!")

  @E_NONEXISTENT_CELL: new Error("Cell does not exists at the given level!")

  @E_ACTOR_NOT_EXISTS: new Error("Given actor does not exists!")

  # Place entity at a given cell
  placeActor: (cell, actor, dir)=>
    @assureCellExistance cell
    @assureCellEmpty cell

    dir = dataTypes.WorldDirection.N unless dir?
    ccp = dataTypes.ActorPosition.get actor, cell, dir
    @data.get("actors").putData(cell, ccp)

  # Move entity from cell to cell
  moveActor: (actor, cell)=>
    @assureActorExists actor
    @assureCellExistance cell
    @assureCellEmpty cell

    ccp = @getActorPosition(actor)
    fromCell = ccp.cell
    toPos = dataTypes.ActorPosition.get actor, cell, ccp.dir

    @data.get("actors").removeData fromCell
    @data.get("actors").putData cell, toPos

  # Remove entity from a given cell
  removeActor: (actor)=>
    @assureActorExists actor

    cell = @getActorPosition(actor).cell

    @assureCellExistance cell
    @assureCellNonEmpty cell

    @data.get("actors").removeData cell

  # Change Actor direction
  # @param {gameLogic.actors.AbstractActor} actor
  # @param {dataTypes.WorldDirection} dir
  changeActorDirection: (actor, dir)=>
    @assureActorExists actor

    cd = @data.get("actors")
    ccp = cd.getDataByEntity(actor)
    ccp.dir = dir
    cd.putData ccp.cell, ccp

  # Gets actor position
  # @param {gameLogic.actors.AbstractActor} actor
  # @return {dataTypes.ActorPosition}
  getActorPosition: (actor)=>
    @data.get("actors").getDataByEntity actor

  # Get all actors positions on the level
  # @return {Array.<dataTypes.ActorPosition>} actor
  getActorsPositions: => @data.get("actors").getEntities()

  # Get all actors on the level
  getActors: => @getActorsPositions().map((a)=> a.actor)

  # section: Helpers

  # @param {dataTypes.WorldCell} cell
  # @return {gameLogic.actors.AbstractActor|undefined}
  getActorByCell: (cell)=>
    pos = @data.get("actors").getData(cell)

    if pos?
      pos.actor
    else
      return undefined

  # Checks whether given cell exist on the level
  assureCellExistance: (cell)=>
    unless @data.get("level").isCellContainsData(cell)
      throw @s.E_NONEXISTENT_CELL

  # Checks whether given cell is non empty
  assureCellEmpty: (cell)=>
    if @data.get("actors").isCellContainsData(cell)
      throw @s.E_NON_EMPTY_CELL

  # Checks whether given cell is empty
  assureCellNonEmpty: (cell)=>
    unless @data.get("actors").isCellContainsData(cell)
      throw @s.E_EMPTY_CELL

  # Checks whether given Actor exists on the level
  # @param {gameLogic.actors.AbstractActor} actor
  assureActorExists: (actor)=>
    unless @data.get("actors").getDataByEntity(actor)
      throw @s.E_ACTOR_NOT_EXISTS









