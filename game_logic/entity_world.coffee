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

  # Section: Entities moving

  @E_NON_EMPTY_CELL: new Error("You are trying perform action on non empty cell!")

  @E_EMPTY_CELL: new Error("You are trying permorm action on empty cell!")

  @E_NONEXISTENT_CELL: new Error("Cell does not exists at the given level!")

  # Place entity at a given cell
  placeEntity: (cell, entity)=>
    @assureCellExistance cell
    @assureCellEmpty cell

    @data.get("entities").putData(cell, entity)

  # Move entity from cell to cell
  moveEntity: (fromCell, toCell, entity)=>

  # Remove entity from a given cell
  removeEntity: (cell, entity)=>
    @assureCellExistance cell
    @assureCellNonEmpty cell

    @data.get("entities").removeData cell


  # section: Helpers

  # Checks whether given cell exist on the level
  assureCellExistance: (cell)=>
    unless @data.get("level").getData(cell)?
      throw @s.E_NONEXISTENT_CELL

  # Checks whether given cell is non empty
  assureCellEmpty: (cell)=>
    if @data.get("entities").getData(cell)?
      throw @s.E_NON_EMPTY_CELL

  # Checks whether given cell is empty
  assureCellNonEmpty: (cell)=>
    unless @data.get("entities").getData(cell)?
      throw @s.E_EMPTY_CELL








