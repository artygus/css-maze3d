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
  # @param {dataTypes.Pos} cell
  # @param {*} entity
  putData: (cell, entity)=>
    super

    @tobject.set "entityToCoords", entity.id.toString(), entity


  # Remove data from a given cell
  # @param {dataTypes.Pos} cell
  removeData: (cell)=>
    d = @getData cell

    @tobject.delete "entityToCoords", d.id.toString()

    super

  # Get data by entity
  # @param {*} entity
  # @return {*}
  getDataByEntity: (entity)=>
    @tobject.get "entityToCoords", entity.id.toString()

  # Get all entities in the matrix
  # @return {Array.<*>}
  getEntities: =>
    collection = []

    for id, entity of @get("entityToCoords")
      collection.push entity

    return collection

  # section: Static

  # Nullified method
  # @param {Object} lobj
  # @return {Null}
  @createFromLevelObject: (lobj)=> null

