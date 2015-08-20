###
  Level serializer
###

utils.serializers.Level =

  # @param {levelEditor.data.LevelCells} level
  # @return {Object}
  serialize: (level)->
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
  serializeToString: (level)->
    JSON.stringify utils.serializers.Level.serialize(level)

  # Parse serialized level
  # @param {Object} serialized
  # @return {Array.<Cell>}
  parseSerialized: (serialized)->
    level = []

    for cid, cell of serialized
      level.push [cell.x, cell.y]

    return level

  # @param {String} serialized
  # @return {String}
  parseSerializedFromString: (serialized)->
    serialized = JSON.parse serialized
    return utils.serializers.Level.parseSerialized(serialized)

  # Serialize from object to world tree
  # @param {levelObj} levelObj Serialized level object
  # @return {Object}
  serializeObjectToWorldTree: (levelObj)->
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









