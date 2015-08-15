###
  Level serializer
###

levelEditor.serializers.Level =

  # @param {levelEditor.data.LevelCells} level
  # @return {Object}
  serialize: (level)->
    h = levelEditor.helpers.Level
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
    JSON.stringify levelEditor.serializers.Level.serialize(level)




