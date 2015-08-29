###
  Abstract actor
###

class gameLogic.actors.AbstractActor extends gameLogic.Object

  @UID_KEY: "actor"

  constructor: ->
    super

    @id = chms.utils.Uniq.gen @s.UID_KEY