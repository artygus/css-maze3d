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
    @data.set "characters", new dataTypes.EntityMatrix2d()

  # Section: Characters positioning

  @E_NON_EMPTY_CELL: new Error("You are trying perform action on non empty cell!")

  @E_EMPTY_CELL: new Error("You are trying permorm action on empty cell!")

  @E_NONEXISTENT_CELL: new Error("Cell does not exists at the given level!")

  @E_CHAR_NOT_EXISTS: new Error("Given character does not exists!")

  # Place entity at a given cell
  placeCharacter: (cell, char, dir)=>
    @assureCellExistance cell
    @assureCellEmpty cell

    dir = dataTypes.WorldDirection.N unless dir?
    ccp = dataTypes.CharacterPosition.get char, cell, dir
    @data.get("characters").putData(cell, ccp)

  # Move entity from cell to cell
  moveCharacter: (fromCell, toCell, char)=>
    @assureCellExistance toCell
    @assureCellEmpty toCell

    ccp = @getCharacterPosition(char)

    @data.get("characters").removeData fromCell
    @data.get("characters").putData toCell, ccp

  # Remove entity from a given cell
  removeCharacter: (cell, char)=>
    @assureCellExistance cell
    @assureCellNonEmpty cell

    @data.get("characters").removeData cell

  # Change character direction
  # @param {gameLogic.characters.AbstractCharacter} char
  # @param {dataTypes.WorldDirection} dir
  changeCharacterDirection: (char, dir)=>
    @assureCharExists char

    cd = @data.get("characters")
    ccp = cd.getDataByEntity(char)
    ccp.dir = dir
    cd.putData ccp.cell, ccp

  # Gets character position
  # @param {gameLogic.characters.AbstractCharacter} char
  # @return {dataTypes.CharacterPosition}
  getCharacterPosition: (char)=>
    @data.get("characters").getDataByEntity char


  # section: Helpers

  # Checks whether given cell exist on the level
  assureCellExistance: (cell)=>
    unless @data.get("level").isCellContainsData(cell)
      throw @s.E_NONEXISTENT_CELL

  # Checks whether given cell is non empty
  assureCellEmpty: (cell)=>
    if @data.get("characters").isCellContainsData(cell)
      throw @s.E_NON_EMPTY_CELL

  # Checks whether given cell is empty
  assureCellNonEmpty: (cell)=>
    unless @data.get("characters").isCellContainsData(cell)
      throw @s.E_EMPTY_CELL

  # Checks whether given character exists on the level
  # @param {gameLogic.characters.AbstractCharacter} char
  assureCharExists: (char)=>
    unless @data.get("characters").getDataByEntity(char)
      throw @s.E_CHAR_NOT_EXISTS









