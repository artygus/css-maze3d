###
  Main level editor app class
###

class levelEditor.App extends levelEditor.Object

  @ATTR_NAME: "app-level-editor"

  DT: "levelEditor.App"

  constructor: (@el)->
    super
    console.log @DT, "Init."

    @data = new levelEditor.data.Editor()

    new levelEditor.view.Grid @

  # section: Static

  @init: ->
    $ ->
      new levelEditor.App(
        $("[app-level-editor]")
      )
