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
    return x + "x" + "y"


