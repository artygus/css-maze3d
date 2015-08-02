###
  Cells of the grid
###

class levelEditor.view.Cells extends levelEditor.Object

  DT: "levelEditor.view.Cells"

  constructor: (@grid, @app)->
    super
    console.log @DT, "Init."

    @dUiModes = @app.data.get("ui-modes")

    @stateInit()

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
      xy = @s.getCellXYByEl(v.el)

      if ((i = _.findIndex(@state.get("selected"), xy)) == -1)
        @state.tarray.push "selected", xy
      else
        @state.tarray.delete "selected", i


  # section: Static

  # sub section: Helpers

  # Get cell x,y by element
  # @return {Array.<String, String>}
  @getCellXYByEl: (el)->
    [el.attr("x"), el.attr("y")]


