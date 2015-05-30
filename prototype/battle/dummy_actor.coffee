###
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
###

class window.DummyActor extends Actor

  act: =>
    super
    entity = @world.findEntityAt(@world.getNextCellFor(@))

    if entity?
      @attack()
    else
      @noop()


  # section: Combat mechanics

  # Current actor health
  HEALTH: 50

  # Max actor health
  MAX_HEALTH: 50

  # Actor damage
  DAMAGE: 10

