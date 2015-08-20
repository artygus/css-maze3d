###
  Player entity
###

class game.entities.Player extends game.Object

  DT: "game.entities.Player"

  constructor: (@app)->
    super

    console.log @DT, "Init."


