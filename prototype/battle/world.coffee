###
  World class
###

class window.World

  DT: "World"

  E_NONEXISTENT_CELL: new Error("Non-existent cell")

  I_UPDATED: "updated"

  constructor: (level)->
    @level = $.extend {}, level
    @entities = []

    @createTime()


  # section: Entities

  # Add given entity to a given position
  addEntity: (entity)=>
    @entities.push entity

    $(entity).one entity.s.I_DIED, @removeAllDiedActors

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
        @actorTurn @entities.slice(0)

      when @ROUND_STATE_END
        @roundState = @ROUND_STATE_START
        @timeStateUpdated()

  TURN_TIME: 10000

  TURN_AFTERTIME: 500

  # Actors acts
  actorTurn: (actors)=>
    if actors.length == 0
      setTimeout (
        =>
          @roundState = @ROUND_STATE_END
          @timeStateUpdated()
      ), @TURN_AFTERTIME

    else
      p = actors[0]

      completed = =>
        p.turnEnded()
        clearTimeout turnTimeout
        @actorTurn actors.slice(1)

      turnTimeout = setTimeout p.noop, @TURN_TIME
      $(p).one p.I_ACTION_COMPLETED, completed

      p.act()

  # Remove died actors
  removeAllDiedActors: =>
    @entities = @entities.filter (e)=> !e.isDied()
    @reactUpdated()

  # section: Positioning

  # @return {Coordinate|null} Coordinate of the entity
  position: (entity, coord)=>
    cc = utils.getCellIndex(coord.x, coord.y)

    if @level[cc]?
      return coord
    else
      console.error @DT, "World does not have a cell at a given coord #{cc}"
      return entity.currentPosition

  # Get next cell for a given entity
  getNextCellFor: (entity)=>
    pos = $.extend {}, entity.currentPosition

    if ["n", "w"].indexOf(pos.d) != -1
      v = -1
    else
      v = 1

    if ["n", "s"].indexOf(pos.d) != -1
      d = "y"
    else
      d = "x"

    pos[d] += v
    cc = utils.getCellIndex(pos.x, pos.y)

    if @level[cc]?
      return {x: pos.x, y: pos.y}
    else
      console.error @DT, "World does not have a cell at a given coord #{cc}"
      return null


  # section: Search

  # Finds entity at given position
  # @param {Object} x/y
  # @return {Entity|null}
  findEntityAt: (pos)=>
    for entity in @entities
      c = entity.currentPosition

      if c.x == pos.x && c.y == pos.y
        return entity

    return null


  # section: Reactions

  reactUpdated: =>
    $(@).trigger @I_UPDATED










