// Generated by CoffeeScript 1.7.1

/*
  World class
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.World = (function() {
    World.prototype.E_NONEXISTENT_CELL = new Error("Non-existent cell");

    function World(level) {
      this.actorsTurns = __bind(this.actorsTurns, this);
      this.timeStateUpdated = __bind(this.timeStateUpdated, this);
      this.createTime = __bind(this.createTime, this);
      this.addEntity = __bind(this.addEntity, this);
      this.level = $.extend({}, level);
      this.entities = [];
      this.createTime();
    }

    World.prototype.addEntity = function(entity) {
      return this.entities.push(entity);
    };

    World.prototype.ROUND_STATE_START = "round state start";

    World.prototype.ROUND_STATE_MOVE = "round state move";

    World.prototype.ROUND_STATE_END = "round state end";

    World.prototype.roundState = void 0;

    World.prototype.createTime = function() {
      this.roundState = this.ROUND_STATE_START;
      return this.timeStateUpdated();
    };

    World.prototype.timeStateUpdated = function() {
      console.log("TIME STATE UPDATED", this.roundState);
      switch (this.roundState) {
        case this.ROUND_STATE_START:
          this.roundState = this.ROUND_STATE_MOVE;
          return this.timeStateUpdated();
        case this.ROUND_STATE_MOVE:
          return this.actorsTurns(this.entities.slice(0));
        case this.ROUND_STATE_END:
          this.roundState = this.ROUND_STATE_START;
          return this.timeStateUpdated();
      }
    };

    World.prototype.TURN_TIME = 10000;

    World.prototype.TURN_AFTERTIME = 1000;

    World.prototype.actorsTurns = function(actors) {
      var completed, p, turnTimeout;
      if (actors.length === 0) {
        return setTimeout(((function(_this) {
          return function() {
            _this.roundState = _this.ROUND_STATE_END;
            return _this.timeStateUpdated();
          };
        })(this)), this.TURN_AFTERTIME);
      } else {
        p = actors[0];
        completed = (function(_this) {
          return function() {
            clearTimeout(turnTimeout);
            return _this.actorsTurns(actors.slice(1));
          };
        })(this);
        turnTimeout = setTimeout(p.noop, this.TURN_TIME);
        $(p).one(p.I_ACTION_COMPLETED, completed);
        return p.act();
      }
    };

    return World;

  })();

}).call(this);
