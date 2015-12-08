###
  Player entity
###

class gameLogic.actors.Player extends gameLogic.actors.AbstractActor

  DT: "gameLogic.actors.Player"

  initState: =>
    @data.set "maxHealth", 200
    @data.set "currentHealth", 200



