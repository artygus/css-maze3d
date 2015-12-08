###
  Abstract actor
###

class gameLogic.actors.AbstractActor extends gameLogic.Object

  @UID_KEY: "actor"

  constructor: (@app)->
    super

    @id = chms.utils.Uniq.gen @s.UID_KEY

    @data = new gameLogic.data.Actor()

    @initState()

    $(@data).asEventStream(@data.s.I_DATA_CHANGED)
      .filter((v)=> v.key == "inCharge" && v.value)
      .onValue @act


  # section: Initialization

  initState: =>


  # section: Turns

  # Actors turn started
  turnStart: =>
    @data.set "inCharge", true

  # Actors turn ended
  turnEnded: =>
    @data.set "inCharge", false


  # section: Acting

  # Perform given action
  performAction: (action)=>
    @assureActorInCharge()

    action()

    @reactActionCompleted()

  # No operation
  actionNoop: =>
    @performAction => null

  act: =>


  # section: Moving

  performMove: (move)=>
    @assureActorExists()
    @assureActorInCharge()

    @performAction move

  actionMove: (forward=true)=>
    @performMove =>
      pos = @getPosition()
      dv = @getMoveDimensionAndVector(pos.cell, pos.dir, forward)

      newPos = [pos.cell[0], pos.cell[1]]
      newPos[dv.dim] += dv.vector

      @app.world.moveActor(@, newPos)

  actionMoveForward: => @actionMove()

  actionMoveBackward: => @actionMove(false)


  # section: Strafe

  actionStrafe: (right=true)=>
    @performMove =>
      pos = @getPosition()
      dv = @getStrafeDimensionAndVector(pos.cell, pos.dir, right)

      newPos = [pos.cell[0], pos.cell[1]]
      newPos[dv.dim] += dv.vector

      @app.world.moveActor(@, newPos)

  actionStrafeLeft: => @actionStrafe(false)

  actionStrafeRight: => @actionStrafe()


  # section: Turns

  actionTurn: (clockwise=true)=>
    @assureActorExists()

    pos = @getPosition()
    nd =  @getNextDirection(pos.dir, clockwise)

    @app.world.changeActorDirection(@, nd)

  actionTurnClockwise: => @actionTurn()

  actionTurnAntiClockwise: => @actionTurn false


  # section: Life/death

  # Let's ask actor: are you dead, buddy?
  # @return {Boolean}
  isDead: => @data.get("currentHealth") < 1


  # section: Combat

  # @param {gameLogic.actors.AbstractActor} from
  # @param {Integer} damage
  receiveDmg: (from, damage)=>
    @data.set "currentHealth", (@data.get("currentHealth") - damage)
    @reactUpdated()
    @reactDead() if @isDead()


  # section: Reactions

  @I_ACTION_COMPLETED: "action_completed"

  @I_UPDATED: "updated"

  @I_DEAD: "dead"

  # Action completed
  reactActionCompleted: =>
    $(@).trigger @s.I_ACTION_COMPLETED

  reactUpdated: =>
    $(@).trigger @s.I_UPDATED

  reactDead: =>
    $(@).trigger @s.I_DEAD


  # section: Helpers

  @E_ACTOR_NOT_IN_CHARGE: new Error("Actor does not in charge!")

  assureActorInCharge: =>
    unless @data.get "inCharge"
      throw @s.E_ACTOR_NOT_IN_CHARGE

  assureActorExists: =>
    @app.world.assureActorExists @

  getPosition: =>
    @app.world.getActorPosition @

  # @return {Object}
  getMoveDimensionAndVector: (cell, direction, forward=true)=>
    wd = dataTypes.WorldDirection

    if direction in [wd.N, wd.S]
      dim = 1 # y
    else
      dim = 0 # x

    if direction in [wd.N, wd.E]
      vector = +1
    else
      vector = -1

    vector *= -1 unless forward

    return {dim: dim, vector: vector}

  getStrafeDimensionAndVector: (cell, direction, right=true)=>
    wd = dataTypes.WorldDirection

    if direction in [wd.N, wd.S]
      dim = 0
    else
      dim = 1

    if direction in [wd.N, wd.W]
      vector = +1
    else
      vector = -1

    vector *= -1 unless right

    return dim: dim, vector: vector

  getNextDirection: (direction, clockwise=true)=>
    wd = dataTypes.WorldDirection
    directions = [wd.N, wd.E, wd.S, wd.W]

    directions.reverse() unless clockwise

    i = directions.indexOf direction
    nexti = i+1

    if nexti > (directions.length - 1)
      return directions[0]
    else if nexti < 0
      return directions[directions.length - 1]
    else
      return directions[nexti]







