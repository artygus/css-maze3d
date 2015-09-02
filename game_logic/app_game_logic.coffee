###
  Game app
###

class gameLogic.App extends gameLogic.Object

  DT: "gameLogic.App"

  constructor: ->
    super

    # Entities
    @world = new gameLogic.entities.World @
    @time = new gameLogic.entities.Time @
    @player = new gameLogic.actors.Player @


