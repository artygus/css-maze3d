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

    console.log "LAM", "Put data", cell, entity
    @tobject.set "entityToCoords", entity.id.toString(), entity


  # Remove data from a given cell
  # @param {Cell} cell
  removeData: (cell)=>
    d = @getData cell

    @tobject.set "entityToCoords", d.id.toString(), undefined

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

