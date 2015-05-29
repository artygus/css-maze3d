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

function drawLevelView(w, h, level) {
  console.log("Draw level view", w, h, level);
  var tc = $("<table>");

  for(var i = 0; i < w; i++) {

    var row = $("<tr>");
    tc.append(row);
    for(var j = 0; j < w; j++) {
      var col = $("<td>");
      row.append(col);

      if(level[getIndex(j,i)]) {
        col.addClass("level-cell");
        level[getIndex(j,i)].cell = col;
      }
    }

  }

  levelView.append(tc);
}

function putPlayerToLevelCell(x, y, d, rlevel) {
  console.log("Move to", x, y);
  var v = rlevel[getIndex(x,y)];
  if(v){
    $("td.with-player", levelView).removeClass("with-player");
    for(var i in directions) {
      var cl = "-d-" + directions[i];
      $("td." + cl, levelView).removeClass(cl);
    }
    v.cell.addClass("with-player");
    v.cell.addClass("-d-" + d);
  } else {
    throw("There is no cell at " + getIndex(x,y));
  }
}



var directions = ["n", "e", "s", "w"];

var KEY_UP = 38,
  KEY_DOWN = 40,
  KEY_LEFT = 37,
  KEY_RIGHT = 39,
  KEY_A = 65;

function refreshPlayerPosition() {
  try{
    putPlayerToLevelCell(playerP.x, playerP.y, playerP.d, level);
    return true;
  } catch(e) {
    console.warn("Moving to unknown cell");
    return false;
  }
};

function handleMove(prop, value) {
  var original = playerP[prop]
  playerP[prop] = value;
  if(!refreshPlayerPosition()) {
    playerP[prop] = original;
    refreshPlayerPosition();
  }
};

function changeD(vector) {
  var cdi = directions.indexOf(playerP.d);

  if(vector > 0) {
    var ndi = cdi + 1;
    if(ndi >= directions.length) ndi = 0;
    playerP.d = directions[ndi];
  } else {
    var ndi = cdi - 1;
    if(ndi < 0) ndi = directions.length - 1;
    playerP.d = directions[ndi];
  }
};

function getVectorByKeyAndDirection(key) {
  var r, dim;

  if(["n", "w"].indexOf(playerP.d) != -1) {
    r = -1;
  } else {
    r = 1;
  }

  if(["n", "s"].indexOf(playerP.d) != -1) {
    dim = "y";
  } else {
    dim = "x";
  }

  if(key == KEY_DOWN) r *= -1;

  return {v: r, dim: dim};
};


