// Generated by CoffeeScript 1.7.1

/*
  Utils
 */

(function() {
  window.utils = {
    directions: ["n", "e", "s", "w"],
    KEY_UP: 38,
    KEY_DOWN: 40,
    KEY_LEFT: 37,
    KEY_RIGHT: 39,
    KEY_A: 65,
    getCellIndex: function(x, y) {
      return x + "x" + y;
    },
    createObjectId: (function(_this) {
      return function() {
        if (utils.createObjectId.__current == null) {
          utils.createObjectId.__current = 0;
        }
        utils.createObjectId.__current++;
        return utils.createObjectId.__current;
      };
    })(this),
    getCoord: (function(_this) {
      return function(x, y, d) {
        return {
          x: x,
          y: y,
          d: d
        };
      };
    })(this),
    getVectorByKeyAndDirection: (function(_this) {
      return function(key, d) {
        var v;
        if (["n", "w"].indexOf(d) !== -1) {
          v = -1;
        } else {
          v = 1;
        }
        if (["n", "s"].indexOf(d) !== -1) {
          d = "y";
        } else {
          d = "x";
        }
        if (key === utils.KEY_DOWN) {
          v *= -1;
        }
        return {
          v: v,
          dim: d
        };
      };
    })(this)
  };

}).call(this);