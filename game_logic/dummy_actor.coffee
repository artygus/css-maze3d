###
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
###

class gameLogic.actors.DummyActor extends gameLogic.actors.AbstractActor

  initState: =>
    @set "maxHealth", 50
    @set "currentHealth", 50

  act: =>
    @actionNoop()