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

  centerLook: function() {
    var closestDirection = this.camera.getDirection();
    this.camera.setTransition(0.3);
    this.direction = closestDirection;
    this.setDirection(closestDirection);
  },

  _bindLookControls: function() {
    var that = this,
        mouseLookTimeout,
        mx = my = 0,
        directions = ['n', 'e', 's', 'w'];

    // mouse
    document.addEventListener('mouseover', function(e) {
      mx = e.pageX;
      my = e.pageY;
      document.removeEventListener('mouseover', arguments.callee)
    }, false);

    document.addEventListener('mousemove', function(e) {
      if (!e.ctrlKey && !e.metaKey) {
        mx = e.pageX;
        my = e.pageY;

        return;
      }

      clearTimeout(mouseLookTimeout);
      that.camera.setTransition(0.1);
      that.camera.rotateDelta(-(e.pageY - my) / 10, -(e.pageX - mx) / 10);

      mx = e.pageX;
      my = e.pageY;
    }, false);

    document.addEventListener('keyup', function(e) {
      if (e.which === 91 || e.which === 17) {
        mouseLookTimeout = setTimeout(that.centerLook.bind(that), 100);
      } 
    }, false);

    // keyboard
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
