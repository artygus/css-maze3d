###
  Abstract actor
###

class gameLogic.actors.AbstractActor extends gameLogic.Object

  @UID_KEY: "actor"

  @AID_ATTACK: "attack"
  @AID_RECEIVE_DMG: "receive_dmg"
  @AID_DEAD: "dead"
  @AID_MOVE: "move"

  MODEL: models.actors.Empty

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

      @app.world.animationTakesPlace(@, @s.AID_MOVE)

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

  # Is actor alive?
  # @return {Boolean}
  isAlive: => not @isDead()

  # section: Combat

  # @param {Integer} diceValue d100 dice value
  # @return {Integer}
  calcDmg: (diceValue)=> 0

  actionAttack: =>
    @performMove =>
      nc = @getNextViewpointCell()

      @app.world.assureCellExistance(nc)
      @app.world.assureCellNonEmpty(nc)

      dmg = @calcDmg()

      victim = @app.world.getActorByCell(nc)
      victim.receiveDmg(@, dmg)

      @app.world.animationTakesPlace(@, @s.AID_ATTACK)

      @reactUpdated()


  # @param {gameLogic.actors.AbstractActor} from
  # @param {Integer} damage
  receiveDmg: (from, damage)=>
    @assureActorExists()
    @data.set "currentHealth", (@data.get("currentHealth") - damage)
    @reactUpdated()

    if @isDead()
      @app.world.animationTakesPlace(@, @s.AID_DEAD)
      @reactDead()
    else
      @app.world.animationTakesPlace(@, @s.AID_RECEIVE_DMG)


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


  # section: Model

  getModel: =>
    unless @_model?
      @_model = new @MODEL()

    return @_model


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

    if direction in [wd.S, wd.E]
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

    if direction in [wd.N, wd.E]
      vector = +1
    else
      vector = -1

    vector *= -1 unless right

    return dim: dim, vector: vector

  getNextDirection: (direction, clockwise=true)=>
    wd = dataTypes.WorldDirection
    directions = [wd.N, wd.E, wd.S, wd.W]

    directions.reverse() if not clockwise

    i = directions.indexOf direction
    nexti = i+1

    if nexti > (directions.length - 1)
      return directions[0]
    else if nexti < 0
      return directions[directions.length - 1]
    else
      return directions[nexti]

  # @return {dataTypes.WorldCell}
  getNextViewpointCell: =>
    pos = @getPosition()
    cp = pos.cell
    md = @getMoveDimensionAndVector(cp, pos.dir)

    if md.dim == 0
      return dataTypes.WorldCell.get cp[0] + md.vector, cp[1]
    else
      return dataTypes.WorldCell.get cp[0], cp[1] + md.vector









