###
  Cells of the grid
###

class levelEditor.view.Cells extends levelEditor.Object

  DT: "levelEditor.view.Cells"

  constructor: (@grid, @app)->
    super
    console.log @DT, "Init."

    @dUiModes = @app.data.get("ui-modes")
    @dLevelCells = @app.data.get("level-cells")

    @initState()
    @initRender()

    @interactionGridClick()


  # section: State

  initState: =>
    @state = new chms.ard.AbstractReactiveData()


  # section: Interactions

  # Grid click
  interactionGridClick: =>

    stream = @grid.asEventStream("click")
      .map((v)=> {el: $(v.target), altKey: v.altKey})
      .filter((v)=> v.el.attr("cell")?)
      .map((v)=> {cell: @s.getCellXYByEl(v.el), altKey: v.altKey})

    stream
      .filter(=> @dUiModes.get("currentMode") == @dUiModes.s.MODE_DESTROY)
      .filter((v)=> @dLevelCells.isCellBelongs(v.cell))
      .onValue (v)=>
        @dLevelCells.removeCell v.cell

    stream
      .filter(=> @dUiModes.get("currentMode") == @dUiModes.s.MODE_BUILD)
      .filter((v)=> !@dLevelCells.isCellBelongs(v.cell))
      .onValue (v)=>
        @dLevelCells.addCell v.cell


  # section: Rendering

  # Init rendering functions
  initRender: =>
    for imp in [@dLevelCells.tarray.s.I_DATA_INSERTED, @dLevelCells.tarray.s.I_DATA_DELETED]
      $(@dLevelCells)
        .asEventStream(imp)
        .filter((v)=> v.key == "levelCells")
        .onValue (v)=>
          if v.type == @dLevelCells.tarray.s.I_DATA_INSERTED
            @drawCellState(v.inserted)
          else
            @drawCellState(v.deleted)

  # Draw current cell state
  # @param {Cell} cell
  drawCellState: (cell)=>
    console.log @DT, "Draw cell state", cell

    el = @s.getCellByXY(cell, @grid)

    if @dLevelCells.isCellBelongs(cell)
      el.addClass "level-cell"
    else
      el.removeClass "level-cell"


  # section: Static

  # sub section: Helpers

  # Get cell x,y by element
  # @return {Cell}
  @getCellXYByEl: (el)->
    [parseInt(el.attr("x")), parseInt(el.attr("y"))]

  # Get cell by x,y
  # @param {Cell} cell
  # @param {jQuery} grid
  @getCellByXY: (cell, grid)=>
    grid.find("[cell][x=#{cell[0]}][y=#{cell[1]}]")



