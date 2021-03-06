// Generated by CoffeeScript 1.7.1

/*
  Actor direction view
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  levelEditor.view.ActorDirection = (function(_super) {
    __extends(ActorDirection, _super);

    ActorDirection.prototype.DT = "levelEditor.view.ActorDirection";

    ActorDirection.VID = "view-leditor-actor-direction";

    function ActorDirection(el, app) {
      this.el = el;
      this.app = app;
      this.checkRadioByDirection = __bind(this.checkRadioByDirection, this);
      this.uncheckAllRadios = __bind(this.uncheckAllRadios, this);
      this.getRadioByDirection = __bind(this.getRadioByDirection, this);
      this.setActorIdText = __bind(this.setActorIdText, this);
      this.stateNoCellSelected = __bind(this.stateNoCellSelected, this);
      this.stateActor = __bind(this.stateActor, this);
      this.stateNoActor = __bind(this.stateNoActor, this);
      this.enableWorldDirectionRadios = __bind(this.enableWorldDirectionRadios, this);
      this.disableWorldDirectionRadios = __bind(this.disableWorldDirectionRadios, this);
      this.getRadios = __bind(this.getRadios, this);
      this.logicUpdateDisableStateOnCellSelected = __bind(this.logicUpdateDisableStateOnCellSelected, this);
      this.logicUpdateActorDirectionOnRadioSelected = __bind(this.logicUpdateActorDirectionOnRadioSelected, this);
      ActorDirection.__super__.constructor.apply(this, arguments);
      console.log(this.DT, "Init.");
      this.dactors = this.app.data.get("level-actors");
      this.logicUpdateDisableStateOnCellSelected();
      this.logicUpdateActorDirectionOnRadioSelected();
    }

    ActorDirection.prototype.logicUpdateActorDirectionOnRadioSelected = function() {
      return this.getRadios().asEventStream("click").filter(this.app.data.isCellSelectedWithActor).onValue((function(_this) {
        return function(e) {
          var actor, dir, s;
          dir = $(e.currentTarget).attr("value");
          s = _this.app.data.get("selected-cell");
          actor = _this.dactors.getActorOnCell(s);
          actor.dir = dir;
          return _this.dactors.updateActor(actor);
        };
      })(this));
    };

    ActorDirection.prototype.logicUpdateDisableStateOnCellSelected = function() {
      var updateState;
      updateState = (function(_this) {
        return function(s) {
          var apos;
          s = _this.app.data.get("selected-cell");
          if (s === null) {
            return _this.stateNoCellSelected();
          } else if ((apos = _this.dactors.getActorOnCell(s)) != null) {
            return _this.stateActor(apos);
          } else {
            return _this.stateNoActor();
          }
        };
      })(this);
      $(this.app.data).asEventStream(this.app.data.s.I_DATA_CHANGED).filter(function(v) {
        return v.key === "selected-cell";
      }).onValue(updateState);
      $(this.dactors).asEventStream(this.app.data.s.I_DATA_CHANGED).filter(function(v) {
        return v.key === "actors";
      }).onValue(updateState);
      return updateState();
    };

    ActorDirection.prototype.getRadios = function() {
      return this.el.find("[type=radio]");
    };

    ActorDirection.prototype.disableWorldDirectionRadios = function() {
      this.el.addClass("-disabled");
      return this.getRadios().attr({
        disabled: true
      });
    };

    ActorDirection.prototype.enableWorldDirectionRadios = function() {
      this.el.removeClass("-disabled");
      return this.getRadios().attr({
        disabled: null
      });
    };

    ActorDirection.prototype.stateNoActor = function() {
      this.disableWorldDirectionRadios();
      this.uncheckAllRadios();
      return this.setActorIdText("No actor");
    };

    ActorDirection.prototype.stateActor = function(apos) {
      this.enableWorldDirectionRadios();
      this.setActorIdText(apos.actor);
      return this.checkRadioByDirection(apos.dir);
    };

    ActorDirection.prototype.stateNoCellSelected = function() {
      this.disableWorldDirectionRadios();
      this.uncheckAllRadios();
      return this.setActorIdText("No cell");
    };

    ActorDirection.prototype.setActorIdText = function(text) {
      return this.el.find("[actor-id]").text(text);
    };

    ActorDirection.prototype.getRadioByDirection = function(dir) {
      return this.el.find("#actor-direction-" + (dir.toLowerCase()));
    };

    ActorDirection.prototype.uncheckAllRadios = function() {
      return this.getRadios().attr({
        checked: null
      });
    };

    ActorDirection.prototype.checkRadioByDirection = function(dir) {
      this.uncheckAllRadios();
      return this.getRadioByDirection(dir).prop({
        checked: true
      });
    };

    return ActorDirection;

  })(levelEditor.Object);

}).call(this);
