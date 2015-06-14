renderGrid = (size) ->
  startAt = Date.now()
  rows = ''
  i = 0
  while i < size
    ii = i.toString()
    cols = ''
    j = 0
    while j < size
      xy = 'x=\'' + j + '\' y=\'' + ii + '\''
      cols += '<div class=\'grid__col\' cell ' + xy + '></div>'
      j++
    rows += '<div class=\'grid__row\'>' + cols + '</div>'
    i++
  container = '<div class=\'grid\'>' + rows + '</div>'
  levelEditorEl.append container
  console.log 'Ended by', Date.now() - startAt
  levelEditorEl.find '.grid'

getCenterGridX = ->
  -Math.round(grid.width() / 2)

getCenterGridY = ->
  -Math.round(grid.height() / 2)

positionGrid = ->
  grid.css
    top: gX
    left: gY
  return

getXYfromCell = (cell) ->
  {
  x: parseInt(cell.attr('x'))
  y: parseInt(cell.attr('y'))
  }

getIndex = (x, y) ->
  x + 'x' + y

makeCell = (x, y)->
  {
    x: x
    y: y
#    n: {type: 'wall', face: 'black-wall'}
#    s: {type: 'wall', face: 'black-wall'}
#    w: {type: 'wall', face: 'black-wall'}
#    e: {type: 'wall', face: 'black-wall'}
  }

centerGrid = ->
  window.gX = getCenterGridX()
  window.gY = getCenterGridY()
  positionGrid()
  return

window.drawLevel = ->
  console.log "Draw level", window.level
  levelEditorEl.find(".level-cell").removeClass "level-cell"

  for index, cell of level
    coords = index.split("x")
    levelEditorEl
      .find("[x='#{coords[0]}'][y='#{coords[1]}']")
      .addClass "level-cell"

desectAll = ->
  grid.find('[cell]').removeClass "-selected"

$ ->
  window.level = {}
  window.levelEditorEl = $('#level-editor')
  window.grid = renderGrid(100)
  centerGrid()

  $(document).on "keyup", (e)->

    switch e.which

      when (KEY_CODE_D = 68)
        desectAll()

  # Cell click
  grid.find('[cell]').on 'click', (e) ->
    el = $(e.target)
    console.log 'Click on', el, e
    xy = getXYfromCell(el)
    ci = getIndex(xy.x, xy.y)

    isSelected = el.hasClass "-selected"

    if !e.shiftKey
      desectAll()

    if isSelected
      el.removeClass "-selected"
    else
      el.addClass "-selected"

