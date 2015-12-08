###
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
###

class gameLogic.actors.Dummy extends gameLogic.actors.AbstractActor

  initState: =>
    @data.set "maxHealth", 50
    @data.set "currentHealth", 50

  act: =>
    super

    victim = @app.world.getActorByCell(@getNextViewpointCell())
    console.log "LAM", "Victim is", victim

    if victim?
      @actionAttack()
    else
      @actionNoop()

  # @param {Integer} diceValue d100 dice value
  # @return {Integer}
  calcDmg: (diceValue)=> 10