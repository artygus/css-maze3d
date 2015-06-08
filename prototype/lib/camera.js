function Camera(viewportEl, worldEl, width, height, cameraEl, unit) {
  this.perspective = 700;
  this.unit = unit;
  this.node = cameraEl;
  this.worldNode = worldEl;

  this.rotate3 = [90, 0, 0];
  this.translate3 = [0, 0, 0];

  viewportEl.style.width = width + 'px';
  viewportEl.style.height = height + 'px';
  viewportEl.style.perspective = this.perspective + 'px';

  cameraEl.style.transformStyle = 'preserve-3d';
  cameraEl.style.transformOrigin = '50% 50% 50px';
  cameraEl.style.position = 'absolute';
  cameraEl.style.top = '50%';
  cameraEl.style.left = '50%';

  worldEl.style.transformStyle = 'preserve-3d';
  worldEl.style.transition = 'transform 0.5s linear'
}

Camera.prototype = {
  setCell: function(x, y) {
    this.translate3[0] = -x * this.unit - this.unit / 2;
    this.translate3[1] = -y * this.unit - this.unit / 2;
  },

  setDirection: function(dir) {
    this.rotate[0] = 0;

    switch(dir) {
      case 'n':
        this.rotate3[2] = 0;
        break;
      case 'e':
        this.rotate3[2] = 90;
        break;
      case 's':
        this.rotate3[2] = 180;
        break;
      case 'w':
        this.rotate3[2] = 270;
    }
  },

  // @param {Array} coord - [x,y]
  // @param {String} dir - direction: n,e,s,w
  set: function(coord, dir) {
    var x = coord[0],
        y = coord[1];

    this.setCell(x, y);
    this.setDirection(dir);

    this.update();
  },

  rotate: function(dx, dz) {
    var newX = this.rotate3[0] + dx;
    if (newX < 180 && newX > 0) {
      this.rotate3[0] = newX;
    }
    this.rotate3[2] += dz;
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
  }
}
