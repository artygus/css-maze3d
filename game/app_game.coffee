###
  Main game app
###

class game.App extends abstract.Object

  DT: "game.App"

  @VID: "app-game"

  constructor: (@el)->
    super
    console.log @DT, "Init."