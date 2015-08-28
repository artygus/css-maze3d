###
  Player entity
###

class gameLogic.characters.Player extends gameLogic.characters.AbstractCharacter

  DT: "gameLogic.characters.Player"

  constructor: (@app)->
    super

    console.log @DT, "Init."


