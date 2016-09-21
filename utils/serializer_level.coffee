###
  Level serializer
###

utils.serializers.Level =

  # @param {levelEditor.data.LevelCells} level
  # @return {Object}
  serializeGeometry: (level)->
    h = utils.helpers.Level
    serialized = {}
    cells = level.get("levelCells")

    for cell in cells
      xcells = h.getCrossCellsForCell(cell)

      cid = h.getCellId(cell)
      serialized[cid] = {
        x: cell[0]
        y: cell[1]
      }

      for d, xcell of xcells

        unless level.isCellBelongs(xcell)
          serialized[cid][d] = {
            face: "black-wall"
            type: "wall"
          }

    return serialized

  # @param {levelEditor.data.LevelCells} level
  # @return {String}
  serializeToString: (level, actors)->
    geometry = utils.serializers.Level.serializeGeometry(level)
    container = dataTypes.Level.get geometry, actors
    JSON.stringify container

  # Parse serialized level
  # @param {Object} serialized
  # @return {Array.<Cell>}
  parseSerializedGeometry: (geometry)->
    level = []

    for cid, cell of geometry
      level.push [cell.x, cell.y]

    return level

  # @param {String} serialized
  # @return {String}
  parseSerializedFromString: (serialized)->
    level = JSON.parse serialized
    geometry = utils.serializers.Level.parseSerializedGeometry(level.geometry)
    actors = []
    return dataTypes.Level.get geometry, actors

  # Serialize from object to world tree
  # @param {levelObj} levelObj Serialized level object
  # @return {Object}
  serializeGeometryToWorldTree: (levelObj)->
    serialized = {}
    for id, cell of levelObj

      unless serialized[cell.x]?
        serialized[cell.x] = {}

      serialized[cell.x][cell.y] =
        n: cell["n"]
        s: cell["s"]
        w: cell["w"]
        e: cell["e"]

    return serialized









