function Camera(viewportEl, worldEl, cameraEl) {
  this.perspective = 1000;
  this.node = cameraEl;
  this.worldNode = worldEl;

  this.rotate3 = [90, 0, 0];
  this.translate3 = [0, 0, 0];

  viewportEl.style.perspective = this.perspective + 'px';

  cameraEl.style.transformStyle = 'preserve-3d';
  cameraEl.style.transformOrigin = '50% 50% 50px';
  cameraEl.style.position = 'absolute';
  cameraEl.style.top = '50%';
  cameraEl.style.left = '50%';

  worldEl.style.transformStyle = 'preserve-3d';
}

Camera.prototype = {
  move: function(x, y) {
    this.translate3[0] = x;
    this.translate3[1] = y;
  },

  rotate: function(x, z) {
    this.rotate3[0] = x;
    this.rotate3[2] = z;
  },

  rotateDelta: function(dx, dz) {
    var newX = this.rotate3[0] + dx,
        newZ = this.rotate3[2] + dz;

    if (newX > 0 && newX < 180) {
      this.rotate3[0] = newX;
    }

    this.rotate3[2] = newZ;
  },

  moveDelta: function(dx, dy, dz) {
    this.translate3[0] += dx;
    this.translate3[1] += dy;
    this.translate3[2] += dz;
  },

  update: function() {
    var axes = ['X','Y','Z'],
        transforms = [];
    // perspective
    transforms.push('translateZ(' + this.perspective * 0.9 + 'px)');
    // rotate
    for(var i in axes) {
      transforms.push('rotate' + axes[i] + '(' + this.rotate3[i] + 'deg)');
    }
    // apply
    this.node.style.transform = transforms.join(' ');
    this.worldNode.style.transform = 'translate3d(' + this.translate3.join('px,') + 'px)';
  },

  setTransition: function(val) {
    this.node.style.transition = val ? 'transform ' + val + 's linear' : '';
  },

  setWorldTransition: function(val) {
    this.worldNode.style.transition = val ? 'transform ' + val + 's linear' : '';
  }
}
