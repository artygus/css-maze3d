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

    @set "gridOffsetX", 0

    @set "gridOffsetY", 0


