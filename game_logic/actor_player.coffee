###
  Player entity
###

class gameLogic.actors.Player extends gameLogic.actors.AbstractActor

  DT: "gameLogic.actors.Player"

  constructor: (@app)->
    super

    console.log @DT, "Init."


