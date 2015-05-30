###
  Utils
###

window.utils =

  directions: ["n", "e", "s", "w"]

  KEY_UP: 38
  KEY_DOWN: 40
  KEY_LEFT: 37
  KEY_RIGHT: 39
  KEY_A: 65

  # @return {String} Cell index
  getCellIndex: (x,y)->
    return x + "x" + y

  # Creates uniq object id
  # @return {Integer}
  createObjectId: =>
    unless utils.createObjectId.__current?
      utils.createObjectId.__current = 0

    utils.createObjectId.__current++
    return utils.createObjectId.__current


  # section: Positioning

  # @return {Coordinate}
  getCoord: (x, y, d)=>
    {x: x, y: y, d: d}

  # @return {Object}
  getVectorByKeyAndDirection: (key, d)=>

    if ["n", "w"].indexOf(d) != -1
      v = -1
    else
      v = 1

    if ["n", "s"].indexOf(d) != -1
      d = "y"
    else
      d = "x"

    if key == utils.KEY_DOWN
      v *= -1

    return {v: v, dim: d}


