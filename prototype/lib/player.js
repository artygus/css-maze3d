function Player(gameCamera) {
  this.x = 0;
  this.y = 0;
  this.direction = 'n';

  this.camera = gameCamera;

  this._bindLookControls();
  this._bindMoveControls();
}

Player.prototype = {
  set: function(x, y, dir) {
    this.x = x;
    this.y = y;
    this.direction = dir;
    this.camera.set(x, y, dir);
  },

  setCell: function(x, y) {
    this.x = x;
    this.y = y;
    this.camera.setCell(x, y);
  },

  setDirection: function(dir) {
    this.direction = dir;
    this.camera.setDirection(dir);
  },

  _bindLookControls: function() {
    var that = this,
        directions = ['n', 'e', 's', 'w'];

    document.addEventListener('keyup', function(e) {
      var inc = 0;

      switch (e.keyCode) {
        case 81:
          inc = 1;
          break;
        case 69:
          inc = -1;
          break;
        default:
          return true;
      }

      var newDirectionIndex = directions.indexOf(that.direction) + inc;

      if (newDirectionIndex >= directions.length) {
        newDirectionIndex = 0;
      } else if (newDirectionIndex < 0){
        newDirectionIndex = directions.length - 1;
      }

      that.camera.setTransition(0.3);
      that.setDirection(directions[newDirectionIndex]);
    }, false);
  },

  _bindMoveControls: function() {
    var that = this;

    document.addEventListener('keyup', function(e) {
      var course;

      switch (e.keyCode) {
        case 83:
          course = 'f';
          break;
        case 68:
          course = 'r';
          break;
        case 87:
          course = 'b';
          break;
        case 65:
          course = 'l';
          break;
        default:
          return true;
      }

      var nCoords = that.camera.getNextCell(that.x, that.y, course);

      if (true/* check for collisions?? */) {
        that.setCell(nCoords[0], nCoords[1]);
      }
    }, false);
  }
}
