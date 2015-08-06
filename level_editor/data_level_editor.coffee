###
  Main editor data file
###

class levelEditor.data.Editor extends chms.ard.AbstractReactiveData

  DT: "levelEditor.data.Editor"

  constructor: ->
    super
    console.log @DT, "Init."

  init: =>
    super

    @set "ui-modes", new levelEditor.data.UiModes()

    @set "level-cells", new levelEditor.data.LevelCells()


