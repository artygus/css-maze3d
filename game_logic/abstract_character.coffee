###
  Abstract character
###

class gameLogic.characters.AbstractCharacter extends gameLogic.Object

  @UID_KEY: "character"

  constructor: ->
    super

    @uid = chms.utils.Uniq.gen @s.UID_KEY