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
    g = @app.data.get
    @textarea.text utils.serializers.Level.serializeToString(
      g("level-cells")
      g("level-actors").get("actors")
    )



