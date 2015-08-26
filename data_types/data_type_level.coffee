###
  This data type represent level
###

class dataTypes.Level extends chms.ard.AbstractReactiveData

  DT: "dataTypes.Level"

  # @param {Object} ltree Serialized level tree
  constructor: (ltree)->
    super

    @set "level", ltree

  init: =>
    super

    # {Object} Level object
    @set "level", null


  # section: Cells

  # Adds given cell to the level
  # @param {Cell} cell
  addCell: (cell)=>
    # TODO: pending

  # Remove given cell from the level
  # @param {Cell} cell
  removeCell: (cell)=>
    # TODO: pending

  # Checks whatever given cell belongs to level or not
  # @param {Cell} cell
  # @return {Boolean}
  isCellBelongs: (cell)=>
    x = @get("level")[cell[0]]

    if x?
      return x[cell[1]]?
    else
      return false


  # section: Static

  # Serializes level object to level tree and return dataTypes.Level
  # @param {Object} lobj
  # @return {dataTypes.Level}
  @createFromLevelObject: (lobj)=>
    new dataTypes.Level(
      utils.serializers.Level.serializeObjectToWorldTree(lobj)
    )



