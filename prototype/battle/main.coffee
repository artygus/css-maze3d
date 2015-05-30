###
  Main file
###

makeCell = =>
  return {
    n: "face",
    s: "face",
    w: "face",
    e: "face"
  }

window.level = {
  "5x0": makeCell(),
  "5x1": makeCell(),
  "5x2": makeCell(),
  "5x3": makeCell(),
  "5x4": makeCell(),
  "5x5": makeCell(),
  "5x6": makeCell(),
  "4x3": makeCell(),
  "3x3": makeCell(),
  "2x3": makeCell(),
  "6x3": makeCell(),
  "7x3": makeCell(),
  "8x3": makeCell()
};

clearLevelView = =>
  levelView.find(".with-player").removeClass "with-player"

  dcl = utils.directions.map((e)=> "-d-#{e}")
  for cl in dcl
    levelView.find(".#{cl}").removeClass(cl)

drawEntities = =>
  for entity in world.entities
    if (p = entity.currentPosition)?
      cc = utils.getCellIndex(p.x, p.y)

      cell = level[cc].cell;
      cell.addClass "with-player"
      cell.addClass "-d-#{p.d}"

drawLevelView = (w, h, level) ->
  console.log 'Draw level view', w, h, level
  tc = $('<table>')
  i = 0
  while i < w
    row = $('<tr>')
    tc.append row
    j = 0
    while j < w
      col = $('<td>')
      row.append col
      if level[utils.getCellIndex(j, i)]
        col.addClass 'level-cell'
        level[utils.getCellIndex(j, i)].cell = col
      j++
    i++
  levelView.append tc

clearActorsView = ->
  actorsView.html("")

drawActorsView = ->
  for entity in world.entities
    v = $("<div>", class: "actor")
    nv = $("<h2>")
    hv = $("<div>", class: "actor__healthbar")

    v.append(nv)
    v.append(hv)

    if entity.constructor == Player
      nv.text "Player"
    else
      nv.text "Actor #{entity.objid}"

    health = (entity.HEALTH/entity.MAX_HEALTH)*100
    hv.css width: "#{health}%"

    actorsView.append v

$ ->

  window.levelView = $("#level-view")
  window.actorsView = $("#actors-view")

  drawLevelView(10, 10, level);

  window.world = new World(level);

  $(world).on world.I_UPDATED, =>
    console.log "Renderer", "World updated"
    clearLevelView()
    drawEntities()
    clearActorsView()
    drawActorsView()

  player = new Player()
  player.place(world, utils.getCoord(5, 6, "n"))

  mob = new DummyActor()
  mob.place(world, utils.getCoord(5, 0, "s"))



