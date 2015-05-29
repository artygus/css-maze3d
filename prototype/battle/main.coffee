###
  Main file
###

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

$ ->

  window.levelView = $("#level-view")

  drawLevelView(10, 10, level);

  window.world = new World(level);

  player = new Player()
  player.place(world, 5, 6, "n")

  mob = new DummyActor()
  mob.place(world, 5, 0, "s")

