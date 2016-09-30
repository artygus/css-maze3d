###
  Level cells data
###

class levelEditor.data.LevelCells extends chms.ard.AbstractReactiveData

  DT: "levelEditor.data.LevelCells"

  FLAG_LEVEL_LOADED: "level-loaded"

  constructor: ->
    super
    console.log @DT, "Init."

  init: =>
    super

    # {Array.<dataTypes.Pos>}
    @set "levelCells", []


  # section: Cells

  # Adds cell to level
  # @param {dataTypes.Pos} cell
  addCell: (cell)=>
    unless @isCellBelongs(cell)
      @tarray.push "levelCells", cell

  # Remove cell from level
  # @param {dataTypes.Pos} cell
  removeCell: (cell)=>
    i = @getCellIndex(cell)

    if i != -1
      @tarray.delete "levelCells", i

  # Is cell belongs to level?
  # @param {dataTypes.Pos} cell
  # @return {Boolean}
  isCellBelongs: (cell)=>
    @getCellIndex(cell) != -1

  # Returns cell index
  # @return {Integer} -1 - cell not found, otherwise positive value
  getCellIndex: (cell)=>
    _.findIndex(@get("levelCells"), cell)


