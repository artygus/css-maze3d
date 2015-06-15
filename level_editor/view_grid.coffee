###
  Level grid
###

class levelEditor.view.Grid extends levelEditor.Object

  DT: "levelEditor.view.Grid"

  constructor: (@app)->
    super
    console.log @DT, "Init."

    @drawInitially()

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