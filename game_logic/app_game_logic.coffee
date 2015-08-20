###
  Game app
###

class gameLogic.App extends gameLogic.Object

  DT: "gameLogic.App"

  constructor: ->
    super

    # Entities
    @world = new gameLogic.entities.World @
    @player = new gameLogic.entities.Player @


