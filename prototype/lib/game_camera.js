function GameCamera(viewportEl, worldEl, cameraEl, unit) {
  this.unit = unit;
  this.camera = new Camera(viewportEl, worldEl, cameraEl);

  this._bindLookControls();
  this.setTransition(0.3);
  this.camera.setWorldTransition(0.5);
}

GameCamera.prototype = {
  _bindLookControls: function() {
    var that = this,
        mouseLookTimeout,
        mx = 0,
        my = 0;

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
    var rotZ = Math.round(this.camera.rotate3[2] / 90) * 90;
    this.setTransition(0.3);

    this.camera.rotate(90, rotZ);
    this.camera.update();
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
      case 'w':
        rotZ = 90;
        break;
      case 's':
        rotZ = 180;
        break;
      case 'e':
        rotZ = 270;
    }

    this.camera.rotate(90, rotZ);
    this.camera.update();
  },

  set: function(x, y, dir) {
    this.setCell(x, y);
    this.setDirection(dir);
  },

  getNextCell: function(x, y, course) {
    var dx, dy;

    switch(course) {
      case 'f':
        dx = Math.sin(this.camera.rotate3[2] * 3.14 / 180);
        dy = Math.cos(this.camera.rotate3[2] * 3.14 / 180);
        break;
      case 'r':
        dx = Math.sin((90 + this.camera.rotate3[2]) * 3.14 / 180);
        dy = Math.cos((90 + this.camera.rotate3[2]) * 3.14 / 180);
        break;
      case 'b':
        dx = -Math.sin(this.camera.rotate3[2] * 3.14 / 180);
        dy = -Math.cos(this.camera.rotate3[2] * 3.14 / 180);
        break;
      case 'l':
        dx = -Math.sin((90 + this.camera.rotate3[2]) * 3.14 / 180);
        dy = -Math.cos((90 + this.camera.rotate3[2]) * 3.14 / 180);
    }

    if (Math.abs(dx) > Math.abs(dy)) {
      return [x + 1 * Math.sign(dx), y];
    } else {
      return [x, y + 1 * Math.sign(dy)];
    }
  },

  getDirection: function() {
    var turnAngle = this.camera.rotate3[2] % 360;

    if (turnAngle >= 135 && turnAngle <= 225) { // 180
      return 's';
    } else if (turnAngle >= 45 && turnAngle <= 135) { // 90
      return 'w';
    } else if (turnAngle >= 315 || turnAngle <= 45) { // 0
      return 'n';
    }

    return 'e';
  },

  rotateDelta: function(dx, dz) {
    this.camera.rotateDelta.apply(this.camera, arguments);
    this.camera.update();
  },

  setTransition: function(val) {
    this.camera.setTransition.apply(this.camera, arguments);
  }
}

