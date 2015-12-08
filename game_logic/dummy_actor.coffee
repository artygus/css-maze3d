###
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
###

class gameLogic.actors.DummyActor extends gameLogic.actors.AbstractActor

  initState: =>
    @data.set "maxHealth", 50
    @data.set "currentHealth", 50

  act: =>
    @actionNoop()

  # @param {Integer} diceValue d100 dice value
  # @return {Integer}
  calcDmg: (diceValue)=> 10