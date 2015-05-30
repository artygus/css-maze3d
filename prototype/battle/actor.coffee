###
  Actor class
###

class window.Actor

  DT: "Actor"

  I_ACTION_COMPLETED: "action_completed"

  I_MOVED: "moved"

  I_UPDATED: "actor:updated"

  I_DIED: "actor:died"

  constructor: ->
    @objid = utils.createObjectId()
    @currentPosition = null

  # section: Interaction

  # Called when actor need perform an action
  act: =>
    @inCharge = true

  # Actors turn ended
  turnEnded: =>
    @inCharge = false


  # section: Actions

  # Noop action
  noop: =>
    return unless @inCharge

    @reactActionCompleted()

  # Move action
  # @param {Coordinate} coord
  move: (coord)=>
    return unless @inCharge

    @position(coord)
    @reactActionCompleted()
    @reactUpdated()

  # Turn
  turn: (vector)=>
    return unless @inCharge

    cdi = utils.directions.indexOf(@currentPosition.d)

    if vector > 0
      ndi = cdi + 1;
      ndi = 0 if ndi >= utils.directions.length
    else
      ndi = cdi - 1;
      ndi = (utils.directions.length - 1) if ndi < 0

    @currentPosition.d = utils.directions[ndi]
    @reactUpdated()

  # Attack
  attack: =>
    return unless @inCharge

    nci = @world.getNextCellFor(@)

    entity = @world.findEntityAt(nci)

    if entity?
      console.log @DT, "#{@objid} perform attack #{entity.objid}", nci

      dmg = @calcDamage(@throwD100Dice())
      entity.receiveDmg(@, dmg)

      @reactUpdated()
      @reactActionCompleted()
    else
      console.warn @DT, "Trying to attack empty cell", JSON.stringify(nci)


  # section: World

  # @param {Coordinate} coord
  place: (@world, coord)=>
    @world.addEntity @
    $(@).on @I_UPDATED, @world.reactUpdated

    @position coord

  # @param {Coordinate|null} coord
  position: (coord)=>
    console.log @DT, "Position #{@objid} to", JSON.stringify(coord)
    @currentPosition = @world.position @, coord
    @reactUpdated()


  # section: Combat mechanics

  # Current actor health
  HEALTH: 100

  # Max actor health
  MAX_HEALTH: 100

  # Actor damage
  DAMAGE: 10

  # Throw d100 dice
  throwD100Dice: => Math.floor(Math.random() * 100)

  # Calculate dmg
  calcDamage: (dice)=> Math.round(@DAMAGE * dice/100)

  # @return {Boolean}
  isDied: =>
    @HEALTH <= 0

  # Receive damage
  # @param {Actor} from
  # @param {Integer} value
  receiveDmg: (from, value)=>
    console.log @DT, "Receive dmg from #{from.objid}", value
    @HEALTH -= value
    @reactUpdated()

    if @isDied()
      @reactDied()

  # section: React

  reactActionCompleted: =>
    $(@).trigger @I_ACTION_COMPLETED

  reactUpdated: =>
    $(@).trigger @I_UPDATED

  reactDied: =>
    console.log @DT, "Died #{@objid}"
    $(@).trigger @I_DIED








