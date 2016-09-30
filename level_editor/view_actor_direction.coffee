###
  Actor direction view
###

class levelEditor.view.ActorDirection extends levelEditor.Object

  DT: "levelEditor.view.ActorDirection"

  @VID: "view-leditor-actor-direction"

  constructor: (@view, @app)->
    super
    console.log @DT, "Init."
