###
  2d matrix with entities.

  All entities in matrix must have id attribute.
###

class dataTypes.EntityMatrix2d extends dataTypes.Matrix2d

  DT: "dataTypes.EntityMatrix2d"

  constructor: ->
    super

  init: =>
    super

    # {Object} Entity to matrix data search tree
    @set "entityToCoords", {}


  # section: Cells

  # Put data to a given cell
  # @param {Cell} cell
  # @param {*} entity
  putData: (cell, entity)=>
    super

    @tobject.set "entityToCoords", entity.id.toString(), entity


  # Remove data from a given cell
  # @param {Cell} cell
  removeData: (cell)=>
    d = @getData cell

    @tobject.set "entityToCoords", d.id.toString(), undefined

    super

  # section: Static

  # Serializes level object to martix2d and return dataTypes.Matrix2d
  # @param {Object} lobj
  # @return {dataTypes.Matrix2d}
  @createFromLevelObject: (lobj)=> null

