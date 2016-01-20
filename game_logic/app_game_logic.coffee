###
  Game app
###

class gameLogic.App extends gameLogic.Object

  DT: "gameLogic.App"

  @ERR_UNDEFINED_ACTOR: new Error("gameLogic.App: Undefined actor!")

  constructor: ->
    super

    # Entities
    @world = new gameLogic.entities.World @
    @time = new gameLogic.entities.Time @
    @player = new gameLogic.actors.Player @


  # section: Helpers

  @ACTOR_PLAYER_ID: "Player"

  # @param {String} id
  # @return {gameLogic.actors.AbstractActor}
  createActorById: (id)=>
    if id == @s.ACTOR_PLAYER_ID
      return @player
    else if gameLogic.actors[id]?
      return new gameLogic.actors[id](@)
    else
      throw @s.ERR_UNDEFINED_ACTOR







