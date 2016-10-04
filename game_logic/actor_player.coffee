###
  Player entity
###

class gameLogic.actors.Player extends gameLogic.actors.AbstractActor

  DT: "gameLogic.actors.Player"

  MODEL: models.actors.Player

  @ASSET_NAME: "player"

  initState: =>
    @data.set "maxHealth", 200
    @data.set "currentHealth", 200

  # @param {Integer} diceValue d100 dice value
  # @return {Integer}
  calcDmg: (diceValue)=> 15



