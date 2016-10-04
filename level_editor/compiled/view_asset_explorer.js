// Generated by CoffeeScript 1.7.1

/*
  Asset explorer view
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  levelEditor.view.AssetExplorer = (function(_super) {
    __extends(AssetExplorer, _super);

    AssetExplorer.prototype.DT = "levelEditor.view.AssetExplorer";

    AssetExplorer.VID = "view-leditor-asset-explorer";

    function AssetExplorer(view, app) {
      this.view = view;
      this.app = app;
      this.templateAssetListItem = __bind(this.templateAssetListItem, this);
      this.renderAssetsList = __bind(this.renderAssetsList, this);
      this.drawPlaceButtonState = __bind(this.drawPlaceButtonState, this);
      this.interactionPlaceAssetBtnClick = __bind(this.interactionPlaceAssetBtnClick, this);
      AssetExplorer.__super__.constructor.apply(this, arguments);
      console.log(this.DT, "Init.");
      this.assetListContainer = this.view.find("[asset-list]");
      this.btnPlaceAsset = this.view.find("[place-asset]");
      this.renderAssetsList();
      this.drawPlaceButtonState();
      this.interactionPlaceAssetBtnClick();
      $(this.app.data).asEventStream(this.app.data.s.I_DATA_CHANGED).filter(function(v) {
        return v.key === "selected-cell";
      }).onValue(this.drawPlaceButtonState);
    }

    AssetExplorer.prototype.interactionPlaceAssetBtnClick = function() {
      return this.btnPlaceAsset.asEventStream("click").onValue((function(_this) {
        return function() {
          var asset, cell;
          asset = _this.assetListContainer.find("[name=asset]:checked");
          cell = _this.app.data.get("selected-cell");
          return _this.app.data.placeActor(dataTypes.ActorPosition.get(asset.attr("asset-id"), cell, dataTypes.WorldDirection.N));
        };
      })(this));
    };

    AssetExplorer.prototype.drawPlaceButtonState = function() {
      if (this.app.data.get("selected-cell") != null) {
        return this.btnPlaceAsset.attr("disabled", null);
      } else {
        return this.btnPlaceAsset.attr("disabled", true);
      }
    };

    AssetExplorer.prototype.renderAssetsList = function() {
      var asset, selected, _i, _len, _ref, _results;
      selected = true;
      _ref = data.Assets;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        asset = _ref[_i];
        this.assetListContainer.append(this.templateAssetListItem(asset, selected));
        _results.push(selected = false);
      }
      return _results;
    };

    AssetExplorer.prototype.templateAssetListItem = function(asset, selected) {
      var id;
      id = "place-asset-" + asset.id;
      selected = selected ? "checked" : "";
      return "<div class=\"radio\">\n  <label for=\"" + id + "\">\n    <input type=\"radio\" name=\"asset\" class=\"list-group-item\" id=\"" + id + "\" " + selected + " asset-id=\"" + asset.id + "\">\n    " + asset.name + "\n  </label>\n</div>";
    };

    return AssetExplorer;

  })(levelEditor.Object);

}).call(this);
