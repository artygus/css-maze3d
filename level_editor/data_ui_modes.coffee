###
  UI modes
###

class levelEditor.data.UiModes extends chms.ard.AbstractReactiveData

  DT: "levelEditor.data.UiModes"

  @MODE_SELECT: "m_select"

  @MODE_NAVIGATE: "m_navigate"

  constructor: ->
    super
    console.log @DT, "Init."

  init: =>
    super

    @set "currentMode", @s.MODE_SELECT