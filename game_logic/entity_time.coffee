###
  Round system
###

class gameLogic.entities.Time extends gameLogic.Object

  DT: "gameLogic.entities.Time"

  constructor: (@app )->
    super

    console.log @DT, "Init."

    @data = new gameLogic.data.Time()

    $(@data).asEventStream(@data.s.I_DATA_CHANGED)
      .filter((v)=> v.key == "state")
      .onValue @stateUpdated

  # section: State machine
  @TURN_TIME: 5000

  @TURN_AFTERTIME: 300

  stateUpdated: =>

    switch @data.get("state")

      when @data.s.ROUND_STATE_START
        @data.set "state", @data.s.ROUND_STATE_TURN
        @stateUpdated()

      when @data.s.ROUND_STATE_TURN
        @data.set "actorsMoveQueue", @app.world.getActors()
        @stateTurn()

      when @data.s.ROUND_STATE_END
        @data.set "state", @data.s.ROUND_STATE_START
        @stateUpdated()

  stateTurn: =>
    actors = @data.get("actorsMoveQueue")

    if actors.length == 0
      setTimeout (
        =>
          @data.set "state", @data.s.ROUND_STATE_END
      ), @TURN_AFTERTIME
    else
      p = actors[0]

      completed = =>
        p.turnEnded()
        clearTimeout turnTimeout
        @data.tarray.delete "actorsMoveQueue", 0
        @stateTurn()

      turnTimeout = setTimeout p.noop, @s.TURN_TIME
      $(p).one p.I_ACTION_COMPLETED, completed

      p.turnStart()

  # section: Start & pause

  create: =>
    @data.setInitialValues()





