###
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
###

class gameLogic.actors.Dummy extends gameLogic.actors.AbstractActor

  MODEL: models.actors.Dummy

  initState: =>
    @data.set "maxHealth", 50
    @data.set "currentHealth", 50

  act: =>
    super

    if !@_previousAction? || @_previousAction == "move_forward"
      @actionMoveBackward()
      @_previousAction = "move_backward"
    else
      @actionMoveForward()
      @_previousAction = "move_forward"

  # @param {Integer} diceValue d100 dice value
  # @return {Integer}
  calcDmg: (diceValue)=> 10