###
  Time data
###

class gameLogic.data.Time extends chms.ard.AbstractReactiveData

  DT: "gameLogic.data.Time"

  @ROUND_STATE_START: "start"

  @ROUND_STATE_TURN: "turn"

  @ROUND_STATE_END: "end"

  constructor: ->
    super

    console.log @DT, "Init."

  init: =>
    super

    # {String} Current state of the time state machine
    @set "state", null

    # {Integer} Number of the current round
    @set "roundNumber", 0

    # {Array.<Actor>} Actors move queue
    @set "actorsMoveQueue", []

  setInitialValues: =>
    @set "state", @s.ROUND_STATE_START
    @set "roundNumber", 1

  @E_NOT_ALL_ACTORS_PERFOMED_ACTION: "Some actors does not perform action in a given round."

  set: (key)=>
    if key == "state" && @get("actorsMoveQueue")? && @get("actorsMoveQueue").length > 0
      throw @s.E_NOT_ALL_ACTORS_PERFOMED_ACTION

    super

