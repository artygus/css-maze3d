###
  Editor hotkeys
###

class levelEditor.modules.Hotkeys extends levelEditor.Object

  DT: "levelEditor.modules.Hotkeys"

  constructor: (@app)->
    super
    console.log @DT, "Init."

    @dUiModes = @app.data.get("ui-modes")

    keyboardJS.bind '1', null, (e)=>
      @dUiModes.set "currentMode", @dUiModes.s.MODE_SELECT

    keyboardJS.bind '2', null, (e)=>
      @dUiModes.set "currentMode", @dUiModes.s.MODE_BUILD

    keyboardJS.bind '3', null, (e)=>
      @dUiModes.set "currentMode", @dUiModes.s.MODE_NAVIGATE

