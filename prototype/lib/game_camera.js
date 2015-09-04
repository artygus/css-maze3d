function GameCamera(viewportEl, worldEl, cameraEl, unit) {
  this.unit = unit;
  this.direction = 'n';
  this.camera = new Camera(viewportEl, worldEl, cameraEl);

  this._bindLookControls();
  this.setTransition(0.3);
  this.camera.setWorldTransition(0.5);
}

GameCamera.prototype = {
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
      that.setTransition(0.1);
      that.rotateDelta(-(e.pageY - my) / 10, -(e.pageX - mx) / 10);

      mx = e.pageX;
      my = e.pageY;
    }, false);

    document.addEventListener('keyup', function(e) {
      if (e.which === 91 || e.which === 17) {
        mouseLookTimeout = setTimeout(that.centerLook.bind(that), 100);
      }
    }, false);
  },

  centerLook: function() {
    // var closestDirection = this.getDirection();
    this.setTransition(0.3);
    this.setDirection(this.direction);
  },

  setCell: function(x, y) {
    this.camera.move(-x * this.unit - this.unit / 2, -y * this.unit - this.unit / 2);
    this.camera.update();
  },

  setDirection: function(dir) {
    var rotZ;

    switch(dir) {
      case 'n':
        rotZ = 0;
        break;
      case 'e':
        rotZ = 90;
        break;
      case 's':
        rotZ = 180;
        break;
      case 'w':
        rotZ = 270;
    }

    this.direction = dir;
    this.camera.rotate(90, rotZ);
    this.camera.update();
  },

  set: function(x, y, dir) {
    this.setCell(x, y);
    this.setDirection(dir);
  },

  getNextCell: function(x, y, course) {
    var walkAxis, walkForwardFactor,
        strafeAxis, strafeLeftFactor,
        turnAngle = this.camera.rotate3[2],
        switchAxis = false;

    if (turnAngle >= 135 && turnAngle <= 225) { // 180
      walkAxis = y;
      walkForwardFactor = -1;
      strafeAxis = x;
      strafeLeftFactor = 1;
    } else if (turnAngle >= 45 && turnAngle <= 135) { // 90
      walkAxis = x;
      walkForwardFactor = 1;
      strafeAxis = y;
      strafeLeftFactor = 1;
      switchAxis = true;
    } else if (turnAngle >= 315 || turnAngle <= 45) { // 0
      walkAxis = y;
      walkForwardFactor = 1;
      strafeAxis = x;
      strafeLeftFactor = -1;
    } else { // 270
      walkAxis = x;
      walkForwardFactor = -1;
      strafeAxis = y;
      strafeLeftFactor = -1;
      switchAxis = true;
    }

    switch(course) {
      case 'f':
        walkAxis += walkForwardFactor;
        break;
      case 'r':
        strafeAxis -= strafeLeftFactor;
        break;
      case 'b':
        walkAxis -= walkForwardFactor;
        break;
      case 'l':
        strafeAxis += strafeLeftFactor;
    }
    return switchAxis ? [walkAxis, strafeAxis] : [strafeAxis, walkAxis];
  },

  getDirection: function() {
    var turnAngle = this.camera.rotate3[2];

    if (turnAngle >= 135 && turnAngle <= 225) { // 180
      return 's';
    } else if (turnAngle >= 45 && turnAngle <= 135) { // 90
      return 'e';
    } else if (turnAngle >= 315 || turnAngle <= 45) { // 0
      return 'n';
    }

    return 'w';
  },

  rotateDelta: function(dx, dz) {
    this.camera.rotateDelta.apply(this.camera, arguments);
    this.camera.update();
  },

  setTransition: function(val) {
    this.camera.setTransition.apply(this.camera, arguments);
  }
}

