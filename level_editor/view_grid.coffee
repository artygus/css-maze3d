###
  Level grid
###

class levelEditor.view.Grid extends levelEditor.Object

  DT: "levelEditor.view.Grid"

  constructor: (@app)->
    super
    console.log @DT, "Init."

    @stateInit()
    @interactionMouseMove()
    @drawInitially()

  # section: State

  stateInit: =>
    @state = new chms.ard.AbstractReactiveData()

    @state.set "gridBlockSize", null
    @state.set "gridBlockX", 0
    @state.set "gridBlockY", 0

    $(@state).on @app.data.s.I_DATA_CHANGED, (v)=>

      switch v.key

        when "gridBlockX", "gridBlockY"
          @drawGridPosition()
          @drawVisibleBlock()

  # section: Rendering

  MAX_GRID_BLOCKS: 5

  GRID_BLOCK_SIZE: 100

  drawInitially: =>
    @el = $ @template()

    @app.el.append @el

    @drawGridPosition()
    @drawInitialBlock()

  INITIAL_BLOCK_XY: [2, 2]

  drawInitialBlock: =>
    b = $ @renderGridBlock()
    @el.append b

    @state.set "gridBlockSize", b.width()

    bxy = @INITIAL_BLOCK_XY
    @positionBlock b, bxy[0], bxy[1]

    gxy = @getGridCoordsByBlock(bxy[0], bxy[1])

    @state.set "gridBlockX", -gxy[0]
    @state.set "gridBlockY", -gxy[1]

    @state.set @getBlockId(gxy[0], gxy[1]), b

  drawGridPosition: =>
    xy = @getGridCoords()
    @positionGrid(xy[0], xy[1])

  drawVisibleBlock: =>
    xy = @getGridCoords()

  # @return {String}
  renderGridBlock: =>
    rows = ""
    for i in [1..@GRID_BLOCK_SIZE]
      cols = ''
      ii = i.toString()
      for j in [1..@GRID_BLOCK_SIZE]
        cols += @templateCell(j, ii)

      rows += @templateRow(cols)

    block = @templateBlock(rows)

    return block

  positionBlock: (block, x, y)=>
    xy = @getGridCoordsByBlock(x, y)
    block.css
      left: xy[0]
      top:  xy[1]

  positionGrid: (x, y)=>
    @el.css
      left: x
      top:  y

  # section: User interactions

  interactionMouseMove: =>
    mdown = $(document).asEventStream("mousedown")
      .filter((e)=> e.which == 1).map(=> mstate: "down")

    mup   = $(document).asEventStream("mouseup").map(=> mstate: "up")
    mmove = $(document).asEventStream("mousemove").map((v)=> x: v.clientX, y: v.clientY)

    prevx = null
    prevy = null

    mup.onValue =>
      prevx = null
      prevy = null

    mouse = mdown
      .merge(mup)
      .combine(mmove, (f,s)=> $.extend(f,s))
      .filter((v)=> v.mstate == "down")
      .map(
        (v)=>
          if prevx? && prevy?
            r = $.extend v, {offsetx: v.x - prevx, offsety: v.y - prevy}
          else
            r = v

          prevx = v.x
          prevy = v.y

          return r
      )

    mouse
      .filter((v)=> v.offsetx? && v.offsety?)
      .onValue (v)=>
        xy = @getGridCoords()
        @state.set "gridBlockX", xy[0] + v.offsetx
        @state.set "gridBlockY", xy[1] + v.offsety


  # section: Templates

  template: =>
    """
      <div class="grid">
      </div>
    """

  templateBlock: (block)=>
    """
      <div class="grid__block">
        #{block}
      </div>
    """

  templateCell: (x, y)=>
    xy = "x=\"#{x}\" y=\"#{y}\""
    """
      <div class="grid__col" #{xy} cell></div>
    """

  templateRow: (cols)=>
    """
      <div class="grid__row">#{cols}</div>
    """


  # section: Helpers

  # @return {Array.<X, Y>}
  getGridCoords: =>
    [
      @state.get("gridBlockX")
      @state.get("gridBlockY")
    ]

  # @return {Array.<X, Y>}
  getGridCoordsByBlock: (x, y)=>
    bs = @state.get "gridBlockSize"

    [x * bs, y * bs]

  # @return {String}
  getBlockId: (x, y)=>
    "block#{x}-#{y}"
