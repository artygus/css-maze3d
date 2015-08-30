###
  Abstract actor
###

class gameLogic.actors.AbstractActor extends gameLogic.Object

  @UID_KEY: "actor"

  constructor: (@app)->
    super

    @id = chms.utils.Uniq.gen @s.UID_KEY

    @data = new gameLogic.data.Actor()

    $(@data).asEventStream(@data.s.I_DATA_CHANGED)
      .filter((v)=> v.key == "inCharge")
      .onValue @act


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

  # No operation
  actionNoop: =>
    @performAction @reactActionCompleted

  act: =>


  # section: Moving

  performMove: (move)=>
    @assureActorExists()

    @performAction move

  actionMove: (forward=true)=>
    @performMove =>
      pos = @getActorPosition()
      dv = @getMoveDimensionAndVector(pos.cell, pos.dir, forward)

      newPos = [pos.cell[0], pos.cell[1]]
      newPos[dv.dim] += dv.vector

      @app.world.moveActor(@, newPos)

  actionMoveForward: => @actionMove()

  actionMoveBackward: => @actionMove(false)

  actionStrafeLeft: =>
    @performMove =>

  actionStrafeRight: =>
    @performMove =>

  actionTurnClockwise: =>
    @performMove =>

  actionTurnAntiClockwise: =>
    @performMove =>


  # section: Reactions

  @I_ACTION_COMPLETED: "action_completed"

  # Action completed
  reactActionCompleted: =>
    $(@).trigger @s.I_ACTION_COMPLETED


  # section: Helpers

  @E_ACTOR_NOT_IN_CHARGE: new Error("Actor does not in charge!")

  assureActorInCharge: =>
    unless @data.get "inCharge"
      throw @s.E_ACTOR_NOT_IN_CHARGE

  assureActorExists: =>
    @app.world.assureActorExists @

  getActorPosition: =>
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


