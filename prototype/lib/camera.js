function Camera(viewportEl, width, height, cameraEl, unit) {
  this.node = cameraEl;
  this.unit = unit;
  this.viewportSize = [width, height];
  this.perspective = 700;

  this.origin3 = [0, 0, 0];
  this.rotate3 = [90, 0, 0];
  this.translate3 = [0, 0, this.perspective * 0.9];

  viewportEl.style.width = width + 'px';
  viewportEl.style.height = height + 'px';
  viewportEl.style.perspective = this.perspective + 'px';
  // viewportEl.style.overflow = 'hidden';

  cameraEl.style.transformStyle = 'preserve-3d';
  // cameraEl.style.transition = 'transform 0.05s'
}

Camera.prototype = {
  // @param {Array} coord - [x,y]
  // @param {String} dir - direction: n,e,s,w
  set: function(coord, dir) {
    var x = coord[0],
        y = coord[1];

    this.setCell(x, y);
    this.setDirection(dir);

    this.update();
  },

  setCell: function(x, y) {
    this.origin3[0] = x * this.unit + this.unit / 2;
    this.origin3[1] = y * this.unit + this.unit / 2;
    this.origin3[2] = this.unit / 2;

    this.translate3[0] = this.viewportSize[0] / 2 - this.origin3[0];
    this.translate3[1] = this.viewportSize[1] / 2 - this.origin3[1];
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
    // translate
    transforms.push('translate3d(' + this.translate3.join('px,') + 'px)');
    // rotate
    for(var i in axes) {
      transforms.push('rotate' + axes[i] + '(' + this.rotate3[i] + 'deg)');
    }
    // apply
    this.node.style.transformOrigin = this.origin3.join('px ') + 'px';
    this.node.style.transform = transforms.join(' ');
  }
}
