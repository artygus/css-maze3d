function Renderer(el, unit) {
  this.node = el;
  this.unit = unit; // unit vector in px
}

Renderer.prototype = {
  // @param {Array} coord - [x,y]
  // @param {String} dir - direction: n,e,s,w
  // @param {String} cls - CSS class
  wall: function(coord, dir, cls) {
    var wallEl = document.createElement('div'),
        x = coord[0] * this.unit,
        y = coord[1] * this.unit,
        origin = [0, 0],
        rotate3 = [0, 0, 0],
        translate3 = [0, 0, 0];

    switch(dir) {
      case 'n':
        origin = [50, 0];
        rotate3 = [1, 0, 0];
        break;
      case 'e':
        x += this.unit;
        origin = [0, 50];
        rotate3 = [0, 1, 0];
        translate3 = [-this.unit, 0, 0];
        break;
      case 's':
        y += this.unit;
        origin = [50, 0];
        rotate3 = [1, 0, 0];
        rotate3 = [1, 0, 0];
        break;
      case 'w':
        origin = [0, 50];
        rotate3 = [0, 1, 0];
        translate3 = [-this.unit, 0, 0];
    }

    wallEl.style.position = 'absolute';
    wallEl.style.left = x + 'px';
    wallEl.style.top = y + 'px';

    wallEl.style.width = this.unit + 'px';
    wallEl.style.height = this.unit + 'px';

    wallEl.style.transform = 'rotate3d(' + rotate3 + ',90deg) translate3d(' + translate3.map(function(p) { return p + 'px ' }) + ')';
    wallEl.style.transformOrigin = origin[0] + '% ' + origin[1] + '%';

    wallEl.className = cls;
    wallEl.setAttribute('data-coord', coord)
    this.node.appendChild(wallEl);
  }
}
