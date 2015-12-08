###
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
###

class gameLogic.actors.DummyActor extends gameLogic.actors.AbstractActor

  act: =>
    @actionNoop()