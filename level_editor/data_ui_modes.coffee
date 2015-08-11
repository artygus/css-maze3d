###
  UI modes
###

class levelEditor.data.UiModes extends chms.ard.AbstractReactiveData

  DT: "levelEditor.data.UiModes"

  @MODE_SELECT: "m_select"

  @MODE_NAVIGATE: "m_navigate"

  @MODE_BUILD: "m_build"

  @MODE_DESTROY: "m_destroy"

  constructor: ->
    super
    console.log @DT, "Init."

  init: =>
    super

    @set "currentMode", @s.MODE_SELECT