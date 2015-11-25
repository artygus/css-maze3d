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
        rotate3 = [0, 0, 0],
        translate3 = [0, 0, this.unit / 2];

    switch(dir) {
      case 'n':
        rotate3 = [90, 0, -180];
        translate3[1] = - this.unit/ 2;
        break;
      case 'e':
        rotate3 = [0, 90, -90];
        translate3[0] = this.unit / 2;
        break;
      case 's':
        rotate3 = [90, 0, -180];
        translate3[1] = this.unit / 2;
        break;
      case 'w':
        rotate3 = [0, 90, -90];
        translate3[0] = - this.unit / 2;
    }

    wallEl.style.position = 'absolute';
    wallEl.style.left = x + 'px';
    wallEl.style.top = y + 'px';

    wallEl.style.width = this.unit + 'px';
    wallEl.style.height = this.unit + 'px';

    var axes = ['X','Y','Z'],
        transforms = [];
    // translate
    transforms.push('translate3d(' + translate3.join('px,') + 'px)');
    // rotate
    for(var i in axes) {
      transforms.push('rotate' + axes[i] + '(' + rotate3[i] + 'deg)');
    }
    // apply
    wallEl.style.transform = transforms.join(' ');

    wallEl.className = cls;
    wallEl.setAttribute('data-coord', coord);
    wallEl.setAttribute('data-direction', dir);
    this.node.appendChild(wallEl);
  },


  item: function(obj, coords, dir) {
    if (obj.type === 'wall') {
      console.log(coords, dir, obj.face);
      this.wall(coords, dir, obj.face);
    } else if (obj.type === 'door') {
      //
    }
  },


  cells: function(data) {
    var directions = ['n', 'e', 's', 'w'];

    for(var k in data) {
      var obj = data[k];

      for(var i in directions) {
        var dir = directions[i];

        if (dir in obj) {
          this.item(obj[dir], [obj.x, obj.y], dir);
        }
      }
    }
  },

  // Section: Models

  modelPlace: function(model, cell, direction) {
    var t = $(model.getTemplate());

    var coords = this.getCellCoords(cell);



    var rotate3 = [0, 0, 0];
    var translate3 = [0, 0, this.unit / 2];

    switch(direction) {
      case 'n':
        rotate3 = [90, 0, -180];
        break;
      case 'e':
        rotate3 = [0, 90, -90];
        break;
      case 's':
        rotate3 = [90, 0, -180];
        break;
      case 'w':
        rotate3 = [0, 90, -90];
    }

    var translate3 = [54, 54, 75];

    var axes = ['X','Y','Z'],
      transforms = [];
    // translate
    transforms.push('translate3d(' + translate3.join('px,') + 'px)');
    // rotate
    for(var i in axes) {
      transforms.push('rotate' + axes[i] + '(' + rotate3[i] + 'deg)');
    }

    transforms.push('scale3d(0.2, 0.2, 0.2)');

    t.css(
      {
        left: coords[0],
        top: coords[1],
        transform: transforms.join(' ')
      }
    );


    $(this.node).append(t);
  },


  // Section: Helpers

  getCellCoords: function(cell) {
    return [cell[0] * this.unit, cell[1] * this.unit];
  }

}
