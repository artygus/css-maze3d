function renderGrid(size) {
  var startAt = Date.now();
  var rows = "";
  for(var i = 0; i < size; i++) {
    var ii = i.toString();

    var cols = "";
    for(var j = 0; j < size; j++) {
      var xy = "x='"+j+"' y='"+ii+"'";
      cols += "<div class='grid__col' cell "+xy+"></div>";
    }
    rows += "<div class='grid__row'>" + cols + "</div>";
  }

  var container = "<div class='grid'>" + rows + "</div>";

  levelEditorEl.append(container);

  console.log("Ended by", Date.now() - startAt);

  return levelEditorEl.find(".grid");
}

function getCenterGridX() {
  return -Math.round(grid.width() / 2);
}

function getCenterGridY() {
  return -Math.round(grid.height() / 2);

}

function positionGrid() {
  grid.css({top: gX, left: gY});
}

function getXYfromCell(cell) {
  return {
    x: parseInt(cell.attr("x")),
    y: parseInt(cell.attr("y"))
  }
}

function getIndex(x,y) {
  return x + "x" + y;
}

function makeCell() {
  return {
    n: "face",
    s: "face",
    w: "face",
    e: "face"
  };
}

function centerGrid() {
  window.gX = getCenterGridX();
  window.gY = getCenterGridY();

  positionGrid();
}


$(function(){
  window.level = {};

  window.levelEditorEl = $("#level-editor");

  window.grid = renderGrid(100);

  centerGrid();

  // Cell click
  grid.find("[cell]").on("click", function(e){
    var el = $(e.target);
    console.log("Click on", el, e);
    var xy = getXYfromCell(el);
    var ci = getIndex(xy.x, xy.y);

    if(e.altKey) {
      el.removeClass("level-cell")
      delete level[ci];
    } else {
      el.addClass("level-cell");
      level[ci] = makeCell();
      level[ci].cell  = el;
    }
  });
});