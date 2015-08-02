###
  Cells of the grid
###

class levelEditor.view.Cells extends levelEditor.Object

  DT: "levelEditor.view.Cells"

  constructor: (@grid, @app)->
    super
    console.log @DT, "Init."

    @dUiModes = @app.data.get("ui-modes")

    @interactionGridClick()


  # section: State

  stateInit: =>
    @state = new chms.ard.AbstractReactiveData()

    @state.set "selected", []


  # section: Interactions

  # Grid click
  interactionGridClick: =>

    @grid.asEventStream("click")
    .map((v)=> {el: $(v.target)})
    .filter((v)=> v.el.attr("cell")?)
    .filter(=> @dUiModes.get("currentMode") == @dUiModes.s.MODE_SELECT)
    .onValue (v)=>
        console.log @DT, "Clicked", v
