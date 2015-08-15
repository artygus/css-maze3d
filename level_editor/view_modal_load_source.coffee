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

    @loadbtn.on "click", @loadBtnClick


  # section: Interactions

  loadBtnClick: =>
    @el.modal('hide')