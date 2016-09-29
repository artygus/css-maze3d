###
  2d position
###

dataTypes.Pos =

  get: (x, y)-> [x, y]

  isEqual: (cell1, cell2)->
    cell1[0] == cell2[0] &&
    cell1[1] == cell2[1]