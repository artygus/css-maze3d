// Generated by CoffeeScript 1.7.1

/*
  Dummy actor attacks player when player in nearest cell
  Most of the times do nothing
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  gameLogic.actors.Dummy = (function(_super) {
    __extends(Dummy, _super);

    function Dummy() {
      this.calcDmg = __bind(this.calcDmg, this);
      this.act = __bind(this.act, this);
      this.initState = __bind(this.initState, this);
      return Dummy.__super__.constructor.apply(this, arguments);
    }

    Dummy.prototype.MODEL = models.actors.Dummy;

    Dummy.ASSET_NAME = "dummy-actor";

    Dummy.prototype.initState = function() {
      this.data.set("maxHealth", 50);
      return this.data.set("currentHealth", 50);
    };

    Dummy.prototype.act = function() {
      Dummy.__super__.act.apply(this, arguments);
      if ((this._previousAction == null) || this._previousAction === "move_forward") {
        this.actionMoveBackward();
        return this._previousAction = "move_backward";
      } else {
        this.actionMoveForward();
        return this._previousAction = "move_forward";
      }
    };

    Dummy.prototype.calcDmg = function(diceValue) {
      return 10;
    };

    return Dummy;

  })(gameLogic.actors.AbstractActor);

}).call(this);
