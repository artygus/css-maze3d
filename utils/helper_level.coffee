###
  Various helpers for level data
###

utils.helpers.Level =

  # Get nearest cross-cells for a given cell
  # @param {Cell} cell
  # @return {Object}
  getCrossCellsForCell: (cell)->
    x = cell[0]
    y = cell[1]

    return {
      n: [x, y-1]
      s: [x, y+1]
      w: [x-1, y]
      e: [x+1, y]
    }

  # Construct cell-id for a given cell
  # @param {Cell} cell
  # @return {String}
  getCellId: (cell)-> "#{cell[0]}x#{cell[1]}"
