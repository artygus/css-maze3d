###
  View source modal
###

class levelEditor.view.ModalSource extends levelEditor.Object

  @VID: "view-leditor-modal-source"

  DT: "levelEditor.view.ModalSource"

  constructor: (@el, @app)->
    super
    console.log @DT, "Init."

    @textarea = @el.find "[name='level-source']"

    @el.on "show.bs.modal", @drawLevelSource


  # section: Rendering

  # Draw level source
  drawLevelSource: =>
    @textarea.text levelEditor.serializers.Level.serializeToString(@app.data.get("level-cells"))



