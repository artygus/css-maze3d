###
  UI mode switch button
###

class levelEditor.view.UIModeSwitchButton extends levelEditor.Object

  @VID: "view-leditor-uimodeswitchbutton"

  DT: "levelEditor.view.UIModeSwitchButton"

  constructor: (@el, @app)->
    super
    console.log @DT, "Init."

    @dUiModes = @app.data.get("ui-modes")

    @mode = @el.attr "mode"
    unless @mode
      throw "#{@DT}: undefined attr mode!"

    $(@dUiModes).on(
      @dUiModes.s.I_DATA_CHANGED
      (e)=>
        if e.key == "currentMode"
          @draw()
    )

    @el.on "click", @updateValue

    @draw()


  # Updates value to widgets mode
  updateValue: =>
    @dUiModes.set "currentMode", @mode


  # section: Rendering

  # Draw widget in current state
  draw: =>
    if @dUiModes.get("currentMode") == @mode
      @el.addClass "active"
    else
      @el.removeClass "active"



