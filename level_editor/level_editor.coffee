###
  Main level editor app class
###

class levelEditor.App extends levelEditor.Object

  @ATTR_NAME: "app-level-editor"

  DT: "levelEditor.App"

  constructor: (@el)->
    super
    console.log @DT, "Init."

    # Data
    @data = new levelEditor.data.Editor()

    # Modules
    new levelEditor.modules.Hotkeys @

    # Views
    new levelEditor.view.Grid @

    @el.find("[#{levelEditor.view.UIModeSwitchButton.VID}]").each (i, v)=>
      new levelEditor.view.UIModeSwitchButton $(v), @


  # section: Static

  @init: ->
    $ ->
      new levelEditor.App(
        $("[app-level-editor]")
      )
