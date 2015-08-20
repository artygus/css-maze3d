function FreeCamera(viewportEl, worldEl, cameraEl, unit) {
  this.unit = unit;
  this.camera = new Camera(viewportEl, worldEl, cameraEl);

  this.camera.setWorldTransition(0.3);
  this.mouseLook(0.5);
  this.keyboardMove(20);
}

FreeCamera.prototype = {
  mouseLook: function(speed) {
    var mx = my = 0,
        that = this;

    document.addEventListener('mouseover', function(e) {
      mx = e.pageX;
      my = e.pageY;
      document.removeEventListener('mouseover', arguments.callee)
    }, false);

    document.addEventListener('mousemove', function(e) {
      that.camera.rotateDelta(-(e.pageY - my) * speed, -(e.pageX - mx) * speed);
      that.camera.update();

      mx = e.pageX;
      my = e.pageY;
    }, false);
  },

  keyboardMove: function(speed) {
    var that = this;

    document.addEventListener('keydown', function(e) {
      var dx, dy, dz = 0;

      switch (e.keyCode) {
        case 83:
          dx = -Math.sin(that.camera.rotate3[2] * 3.14 / 180);
          dy = -Math.cos(that.camera.rotate3[2] * 3.14 / 180);
          dz = -Math.cos(-that.camera.rotate3[0] * 3.14 / 180);
          break;
        case 68:
          dx = -Math.sin((90 + that.camera.rotate3[2]) * 3.14 / 180);
          dy = -Math.cos((90 + that.camera.rotate3[2]) * 3.14 / 180);
          break;
        case 87:
          dx = Math.sin(that.camera.rotate3[2] * 3.14 / 180);
          dy = Math.cos(that.camera.rotate3[2] * 3.14 / 180);
          dz = Math.cos(-that.camera.rotate3[0] * 3.14 / 180);
          break;
        case 65:
          dx = Math.sin((90 + that.camera.rotate3[2]) * 3.14 / 180);
          dy = Math.cos((90 + that.camera.rotate3[2]) * 3.14 / 180);
          break;
        default:
          return true;
      }

      requestAnimationFrame(function() {
        that.camera.moveDelta(dx * speed, dy * speed, dz * speed);
        that.camera.update();
      });
    }, false);
  }
}
