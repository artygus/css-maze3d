###
  Actor's data
###

class gameLogic.data.Actor extends chms.ard.AbstractReactiveData

  DT: "gameLogic.data.Actor"

  constructor: ->
    super

    console.log @DT, "Init."

  init: =>
    super

    # {Boolean} Is actor can perform action?
    @set "inCharge", false

    # {Integer} Max actor health
    @set "maxHealth", 0

    # {Integer} Current actor health
    @set "currentHealth", 0


  # section: Helpers

  # @return {Float}
  getCurrentHealthInPercent: =>
    v = @get("currentHealth") / @get("maxHealth")

    if isNaN(v)
      return 0
    else
      return v


