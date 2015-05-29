###
  World class
###

class window.World

  E_NONEXISTENT_CELL: new Error("Non-existent cell")

  constructor: (level)->
    @level = $.extend {}, level
    @entities = []

    @createTime()


  # section: Entities

  # Add given entity to a given position
  addEntity: (entity)=>
    @entities.push entity

  # section: Round system

  ROUND_STATE_START: "round state start"

  ROUND_STATE_MOVE:  "round state move"

  ROUND_STATE_END:   "round state end"

  roundState: undefined

  # Creates time
  createTime: =>
    @roundState = @ROUND_STATE_START
    @timeStateUpdated()

  # Runs time
  timeStateUpdated: =>
    console.log "TIME STATE UPDATED", @roundState
    switch @roundState

      when @ROUND_STATE_START
        @roundState = @ROUND_STATE_MOVE
        @timeStateUpdated()

      when @ROUND_STATE_MOVE
        @actorsTurns @entities.slice(0)

      when @ROUND_STATE_END
        @roundState = @ROUND_STATE_START
        @timeStateUpdated()

  TURN_TIME: 10000

  TURN_AFTERTIME: 1000

  # Actors acts
  actorsTurns: (actors)=>
    if actors.length == 0
      setTimeout (
        =>
          @roundState = @ROUND_STATE_END
          @timeStateUpdated()
      ), @TURN_AFTERTIME

    else
      p = actors[0]

      completed = =>
        clearTimeout turnTimeout
        @actorsTurns actors.slice(1)

      turnTimeout = setTimeout p.noop, @TURN_TIME
      $(p).one p.I_ACTION_COMPLETED, completed

      p.act()








