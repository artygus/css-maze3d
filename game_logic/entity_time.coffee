###
  Round system
###

class gameLogic.entities.Time extends gameLogic.Object

  DT: "gameLogic.entities.Time"

  constructor: (@app )->
    super

    console.log @DT, "Init."

    @data = new gameLogic.data.Time()


  # section: State machine
  @TURN_TIME: 5000

  @TURN_AFTERTIME: 300

  stateUpdated: =>

    switch @data.get("state")

      when @data.s.ROUND_STATE_START
        @data.set "state", @data.s.ROUND_STATE_TURN
        @stateUpdated()

      when @data.s.ROUND_STATE_TURN
        @stateTurn @app.world.getActors()

      when @data.s.ROUND_STATE_END
        @data.set "state", @data.s.ROUND_STATE_START
        @stateUpdated()

  stateTurn: (actors)=>
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
        @stateTurn actors.slice 1

      turnTimeout = setTimeout p.noop, @s.TURN_TIME
      $(p).one p.I_ACTION_COMPLETED, completed

      p.turnStart()

  # section: Start & pause

  create: =>
    @data.setInitialValues()
    @stateUpdated()





