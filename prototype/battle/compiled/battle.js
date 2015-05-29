function getNextCell() {
  var v = getVectorByKeyAndDirection(KEY_UP);
  var ppc = $.extend({}, playerP);
  ppc[v.dim] += v.v;
  return [ppc.x, ppc.y];
}

function attack() {
  var nextCell = getNextCell();

  var ci = getIndex(nextCell[0], nextCell[1]);
  var cell = level[ci].cell;

  if(cell) {
    cell.css("background", "red");
  } else {
    console.warn("Trying to attack unknown cell " + ci);
  }

  console.log("Attack!", nextCell);
}

// Round system

ROUND_STATE_START = "round state start";
ROUND_STATE_MOVE  = "round state move";
ROUND_STATE_END   = "round state end";

MOVE_TIME = 10000;









