// Generated by CoffeeScript 1.7.1

/*
  World entity
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  gameLogic.entities.World = (function(_super) {
    __extends(World, _super);

    World.prototype.DT = "gameLogic.entities.World";

    function World(app) {
      this.app = app;
      this.assureActorExists = __bind(this.assureActorExists, this);
      this.assureCellNonEmpty = __bind(this.assureCellNonEmpty, this);
      this.assureCellEmpty = __bind(this.assureCellEmpty, this);
      this.assureCellExistance = __bind(this.assureCellExistance, this);
      this.getActorByCell = __bind(this.getActorByCell, this);
      this.animationTakesPlace = __bind(this.animationTakesPlace, this);
      this.getDeadActors = __bind(this.getDeadActors, this);
      this.getAliveActors = __bind(this.getAliveActors, this);
      this.getActors = __bind(this.getActors, this);
      this.getActorsPositions = __bind(this.getActorsPositions, this);
      this.getActorPosition = __bind(this.getActorPosition, this);
      this.changeActorDirection = __bind(this.changeActorDirection, this);
      this.removeDeadActors = __bind(this.removeDeadActors, this);
      this.removeActor = __bind(this.removeActor, this);
      this.moveActor = __bind(this.moveActor, this);
      this.placeActor = __bind(this.placeActor, this);
      this.load = __bind(this.load, this);
      World.__super__.constructor.apply(this, arguments);
      console.log(this.DT, "Init world.");
      this.data = new gameLogic.data.World();
    }

    World.prototype.load = function(level) {
      this.data.set("level", dataTypes.Matrix2d.createFromLevelObject(level));
      return this.data.set("actors", new dataTypes.EntityMatrix2d());
    };

    World.E_NON_EMPTY_CELL = new Error("You are trying perform action on non empty cell!");

    World.E_EMPTY_CELL = new Error("You are trying permorm action on empty cell!");

    World.E_NONEXISTENT_CELL = new Error("Cell does not exists at the given level!");

    World.E_ACTOR_NOT_EXISTS = new Error("Given actor does not exists!");

    World.prototype.placeActor = function(cell, actor, dir) {
      var ccp;
      this.assureCellExistance(cell);
      this.assureCellEmpty(cell);
      if (dir == null) {
        dir = dataTypes.WorldDirection.N;
      }
      ccp = dataTypes.ActorPosition.get(actor, cell, dir);
      return this.data.get("actors").putData(cell, ccp);
    };

    World.prototype.moveActor = function(actor, cell) {
      var ccp, fromCell, toPos;
      this.assureActorExists(actor);
      this.assureCellExistance(cell);
      this.assureCellEmpty(cell);
      ccp = this.getActorPosition(actor);
      fromCell = ccp.cell;
      toPos = dataTypes.ActorPosition.get(actor, cell, ccp.dir);
      this.data.get("actors").removeData(fromCell);
      return this.data.get("actors").putData(cell, toPos);
    };

    World.prototype.removeActor = function(actor) {
      var cell;
      this.assureActorExists(actor);
      cell = this.getActorPosition(actor).cell;
      this.assureCellExistance(cell);
      this.assureCellNonEmpty(cell);
      return this.data.get("actors").removeData(cell);
    };

    World.prototype.removeDeadActors = function() {
      var actor, _i, _len, _ref, _results;
      _ref = this.getDeadActors();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        actor = _ref[_i];
        _results.push(this.removeActor(actor));
      }
      return _results;
    };

    World.prototype.changeActorDirection = function(actor, dir) {
      var ccp, cd;
      this.assureActorExists(actor);
      cd = this.data.get("actors");
      ccp = cd.getDataByEntity(actor);
      ccp.dir = dir;
      return cd.putData(ccp.cell, ccp);
    };

    World.prototype.getActorPosition = function(actor) {
      return this.data.get("actors").getDataByEntity(actor);
    };

    World.prototype.getActorsPositions = function() {
      return this.data.get("actors").getEntities();
    };

    World.prototype.getActors = function() {
      return this.getActorsPositions().map(function(a) {
        return a.actor;
      });
    };

    World.prototype.getAliveActors = function() {
      return this.getActors().filter(function(a) {
        return a.isAlive();
      });
    };

    World.prototype.getDeadActors = function() {
      return this.getActors().filter(function(a) {
        return a.isDead();
      });
    };

    World.prototype.animationTakesPlace = function(actor, animationId) {
      var timeout;
      timeout = actor.getModel().animate(animationId);
      return this.app.time.maxTurnDelay(timeout);
    };

    World.prototype.getActorByCell = function(cell) {
      var pos;
      pos = this.data.get("actors").getData(cell);
      if (pos != null) {
        return pos.actor;
      } else {
        return void 0;
      }
    };

    World.prototype.assureCellExistance = function(cell) {
      if (!this.data.get("level").isCellContainsData(cell)) {
        throw this.s.E_NONEXISTENT_CELL;
      }
    };

    World.prototype.assureCellEmpty = function(cell) {
      if (this.data.get("actors").isCellContainsData(cell)) {
        throw this.s.E_NON_EMPTY_CELL;
      }
    };

    World.prototype.assureCellNonEmpty = function(cell) {
      if (!this.data.get("actors").isCellContainsData(cell)) {
        throw this.s.E_EMPTY_CELL;
      }
    };

    World.prototype.assureActorExists = function(actor) {
      if (!this.data.get("actors").getDataByEntity(actor)) {
        throw this.s.E_ACTOR_NOT_EXISTS;
      }
    };

    return World;

  })(gameLogic.Object);

}).call(this);
