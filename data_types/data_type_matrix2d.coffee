###
  This data type represent 2d matrix
###

class dataTypes.Matrix2d extends chms.ard.AbstractReactiveData

  DT: "dataTypes.Matrix2d"

  # @param {Object} data Matrix data
  constructor: (data={})->
    super

    @set "mdata", data

  init: =>
    super

    # {Object} Matrix data
    @set "mdata", null


  # section: Cells

  # Put data to a given cell
  # @param {Cell} cell
  # @param {*} data
  putData: (cell, data)=>
    @tobject.set "mdata", "#{cell[0]}.#{cell[1]}", data

  # Remove data from a given cell
  # @param {Cell} cell
  removeData: (cell)=>
    @tobject.set "mdata", "#{cell[0]}.#{cell[1]}", undefined

  # Get data from a given cell
  # @param {Cell} cell
  # @return {*}
  getData: (cell)=>
    @tobject.get "mdata", "#{cell[0]}.#{cell[1]}"

  # Checks whatever given cell contains data or not
  # @param {Cell} cell
  # @return {Boolean}
  isCellContainsData: (cell)=> @getData(cell)?


  # section: Helpers

  # Get flat cell coords
  # @return {Array.<Cell>}
  getFlatCellCoords: =>
    cells = []
    mdata = @get("mdata")

    for x, row of mdata
      for y, col of row
        cells.push [x, y]

    return cells


  # section: Static

  # Serializes level object to martix2d and return dataTypes.Matrix2d
  # @param {Object} lobj
  # @return {dataTypes.Matrix2d}
  @createFromLevelObject: (lobj)=>
    new dataTypes.Matrix2d(
      utils.serializers.Level.serializeObjectToWorldTree(lobj)
    )



