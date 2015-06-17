###
  Level grid
###

class levelEditor.view.Grid extends levelEditor.Object

  DT: "levelEditor.view.Grid"

  constructor: (@app)->
    super
    console.log @DT, "Init."

    @drawInitially()
    @drawPosition()

    @interactionMouseMove()

    $(@app.data).on @app.data.s.I_DATA_CHANGED, (v)=>

      switch v.key

        when "gridOffsetX", "gridOffsetY"
          @drawPosition()


  # section: Rendering

  GRID_SIZE: 100

  drawInitially: =>
    rows = ""
    for i in [1..@GRID_SIZE]
      cols = ''
      ii = i.toString()
      for j in [1..@GRID_SIZE]
        cols += @templateCell(j, ii)

      rows += @templateRow(cols)

    @el = $ @template(rows)

    @app.el.append @el

  drawPosition: =>
    @el.css
      left: @app.data.get("gridOffsetX")
      top: @app.data.get("gridOffsetY")


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
        @app.data.set "gridOffsetX", @app.data.get("gridOffsetX") + v.offsetx
        @app.data.set "gridOffsetY", @app.data.get("gridOffsetY") + v.offsety

  # section: Templates

  template: (rows)=>
    """
      <div class="grid">
        #{rows}
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