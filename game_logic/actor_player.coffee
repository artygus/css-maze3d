###
  Player entity
###

class gameLogic.actors.Player extends gameLogic.actors.AbstractActor

  DT: "gameLogic.actors.Player"

  initState: =>
    @set "maxHealth", 200
    @set "currentHealth", 200



