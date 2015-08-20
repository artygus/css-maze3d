'use strict';

function GameCamera(viewportEl, worldEl, cameraEl, unit) {
  this.unit = unit;
  this.camera = new Camera(viewportEl, worldEl, cameraEl);

  this.camera.setWorldTransition(0.5);
}

GameCamera.prototype = {
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

