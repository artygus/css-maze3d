###
  This data type represent 2d matrix
###

class dataTypes.Matrix2d extends chms.ard.AbstractReactiveData

  DT: "dataTypes.Matrix2d"

  # @param {Object} data Matrix data
  constructor: (data)->
    super

    @set "mdata", data

  init: =>
    super

    # {Object} Matrix data
    @set "mdata", null


  # section: Cells

  # Puts data to a given cell
  # @param {Cell} cell
  putData: (cell)=>
    # TODO: pending

  # Remove data from a given cell
  # @param {Cell} cell
  removeData: (cell)=>
    # TODO: pending

  # Checks whatever given cell contains data or not
  # @param {Cell} cell
  # @return {Boolean}
  isCellContainsData: (cell)=>
    x = @get("mdata")[cell[0]]

    if x?
      return x[cell[1]]?
    else
      return false


  # section: Static

  # Serializes level object to martix2d and return dataTypes.Matrix2d
  # @param {Object} lobj
  # @return {dataTypes.Matrix2d}
  @createFromLevelObject: (lobj)=>
    new dataTypes.Matrix2d(
      utils.serializers.Level.serializeObjectToWorldTree(lobj)
    )



