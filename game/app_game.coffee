###
  Game app
###

class game.App extends game.Object

  DT: "game.App"

  constructor: ->
    super

    # Entities
    @world = new game.entities.World @
    @player = new game.entities.Player @


