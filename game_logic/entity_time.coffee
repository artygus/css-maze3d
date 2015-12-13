###
  Round system
###

class gameLogic.entities.Time extends gameLogic.Object

  DT: "gameLogic.entities.Time"

  constructor: (@app )->
    super

    console.log @DT, "Init."

    @data = new gameLogic.data.Time()

    @clearTurnDelay()

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

      when @data.s.ROUND_STATE_TURN
        @data.set "actorsMoveQueue", @app.world.getAliveActors()
        @stateTurn()

      when @data.s.ROUND_STATE_END
        @data.set "state", @data.s.ROUND_STATE_START

  stateTurn: =>
    actors = @data.get("actorsMoveQueue")

    if actors.length == 0
      setTimeout (
        =>
          @data.set "state", @data.s.ROUND_STATE_END
      ), @s.TURN_AFTERTIME
    else
      p = actors[0]

      completed = =>
        p.turnEnded()
        clearTimeout turnTimeout
        @data.tarray.delete "actorsMoveQueue", 0
        setTimeout @stateTurn, @getTurnDelay()

      turnTimeout = setTimeout p.actionNoop, @s.TURN_TIME
      $(p).one p.s.I_ACTION_COMPLETED, completed

      p.turnStart()

  # section: Start & pause

  create: =>
    @data.setInitialValues()

  # Set turn delay
  # @param {Integer} ms
  setTurnDelay: (ms)=>
    @_turnDelay = ms

  # Get turn delay
  # @return {Integer}
  getTurnDelay: => @_turnDelay

  # Clear turn delay
  clearTurnDelay: =>
    @setTurnDelay 0

  # Max turn delay
  # @param {Integer} ms
  maxTurnDelay: (ms)=>
    @setTurnDelay(
      Math.max @getTurnDelay(), ms
    )






