###
  Load source modal dialog
###

class levelEditor.view.ModalLoadSource extends levelEditor.Object

  @VID: "view-leditor-modal-load-source"

  DT: "levelEditor.view.ModalLoadSource"

  constructor: (@el, @app)->
    super
    console.log @DT, "Init."

    @loadbtn = @el.find "[load]"
    @textarea = @el.find "textarea[name=level-source]"

    @loadbtn.on "click", @loadBtnClick

    @el.on "hidden.bs.modal", @clearForm


  # section: Interactions

  loadBtnClick: =>
    @loadLevel()
    @el.modal('hide')


  # section: Load

  loadLevel: =>
    lobject = @textarea.val()

    if lobject.length > 0
      h = utils.serializers.Level
      level = h.parseSerializedFromString(lobject)

      lc = @app.data.get("level-cells")
      extraData = {}
      extraData[lc.FLAG_LEVEL_LOADED] = true
      lc.set "levelCells", level, extraData


  # section: Rendering

  clearForm: =>
    @textarea.val ""


