###
  Level grid
###

class levelEditor.view.Grid extends levelEditor.Object

  DT: "levelEditor.view.Grid"

  constructor: (@app)->
    super
    console.log @DT, "Init."

    @dUiModes = @app.data.get("ui-modes")

    @stateInit()
    @interactionMouseMove()
    @drawInitially()

  # section: State

  stateInit: =>
    @state = new chms.ard.AbstractReactiveData()

    @state.set "gridBlockSize", null
    @state.set "gridX", 0
    @state.set "gridY", 0
    @state.set "blocks", {}

    $(@state).on @app.data.s.I_DATA_CHANGED, (v)=>

      switch v.key

        when "gridX", "gridY"
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

    new levelEditor.view.Cells(@el, @app)

  INITIAL_BLOCK_XY: [2, 2]

  drawInitialBlock: =>
    bxy = @INITIAL_BLOCK_XY
    @drawBlock bxy[0], bxy[1]

    gxy = @getGridXYByBlockXY(bxy[0], bxy[1])
    gxy = @handleGridPosition(-gxy[0], -gxy[1])

    @state.set "gridX", gxy[0]
    @state.set "gridY", gxy[1]

  drawGridPosition: =>
    xy = @getGridXY()
    @positionGrid(xy[0], xy[1])

  drawVisibleBlock: =>
    xy = @getGridXY()
    windoww = $(window).width()
    windowh = $(window).height()

    xyTopLeft     = [-xy[0], -xy[1]]
    xyTopRight    = [xyTopLeft[0] + windoww, xyTopLeft[1]]
    xyBottomLeft  = [xyTopLeft[0], xyTopLeft[1] + windowh]
    xyBottomRight = [xyTopRight[0], xyBottomLeft[1]]

    xys = [xyTopLeft, xyTopRight, xyBottomLeft, xyBottomRight]

    visible = []

    for xy in xys
      bxy = @getBlockXYByGridXY(xy[0], xy[1])

      bid = @getBlockId(bxy[0], bxy[1])

      unless @state.get("blocks")[bid]?
        @drawBlock bxy[0], bxy[1]

      block = @state.get("blocks")[bid]
      block.show()

      visible.push block

    for key, block of @state.get("blocks")
      if visible.indexOf(block) == -1
        block.hide()


  # @param {Integer} blockx
  # @param {Integer} blocky
  # @return {jQuery}
  drawBlock: (blockx, blocky)=>
    b = $ @renderGridBlock(blockx, blocky)
    @el.append b

    unless @state.get("gridBlockSize")?
      @state.set "gridBlockSize", b.width()

    @positionBlock b, blockx, blocky
    @state.get("blocks")[@getBlockId(blockx, blocky)] = b

    return b

  # @param {Integer} blockx
  # @param {Integer} blocky
  # @return {String}
  renderGridBlock: (blockx, blocky)=>
    rows = ""
    for i in [1..@GRID_BLOCK_SIZE]
      cols = ''
      for j in [1..@GRID_BLOCK_SIZE]
        cols += @templateCell(j, i, blockx, blocky)

      rows += @templateRow(cols)

    block = @templateBlock(rows)

    return block

  positionBlock: (block, gridx, gridy)=>
    xy = @getGridXYByBlockXY(gridx, gridy)
    block.css
      left: xy[0]
      top:  xy[1]

  positionGrid: (gridx, gridy)=>
    @el.css
      left: gridx
      top:  gridy

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
      .filter(=> @dUiModes.get("currentMode") == @dUiModes.s.MODE_NAVIGATE)
      .onValue (v)=>
        xy = @getGridXY()
        xy = @handleGridPosition(xy[0] + v.offsetx, xy[1] + v.offsety)

        @state.set "gridX", xy[0]
        @state.set "gridY", xy[1]


  # section: Handlers

  # @return {Array.<Integer, Integer>}
  handleGridPosition: (x, y)=>
    max = -(@state.get("gridBlockSize") * @MAX_GRID_BLOCKS)

    xy = []

    for dim in [x, y]
      r = Math.min(0, dim)
      r = Math.max(max, r)

      xy.push r

    return xy

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

  # @param {Integer} x
  # @param {Integer} y
  # @param {Integer} blockx
  # @param {Integer} blocky
  templateCell: (x, y, blockx, blocky)=>
    tx = x + @GRID_BLOCK_SIZE * blockx
    ty = y + @GRID_BLOCK_SIZE * blocky
    xy = "x=\"#{tx}\" y=\"#{ty}\""
    """
      <div class="grid__col" #{xy} cell></div>
    """

  templateRow: (cols)=>
    """
      <div class="grid__row">#{cols}</div>
    """


  # section: Helpers

  # @return {Array.<X, Y>}
  getGridXY: =>
    [
      @state.get("gridX")
      @state.get("gridY")
    ]

  # @return {Array.<X, Y>}
  getGridXYByBlockXY: (blockx, blocky)=>
    bs = @state.get "gridBlockSize"

    [blockx * bs, blocky * bs]

  # @return {String}
  getBlockId: (blockx, blocky)=>
    "block#{blockx}-#{blocky}"

  # @return {Array.<X, Y>}
  getBlockXYByGridXY: (gridx, gridy)=>
    bs = @state.get "gridBlockSize"

    [
      Math.floor gridx / bs
      Math.floor gridy / bs
    ]



