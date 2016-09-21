###
  Asset explorer view
###

class levelEditor.view.AssetExplorer extends levelEditor.Object

  DT: "levelEditor.view.AssetExplorer"

  @VID: "view-leditor-asset-explorer"

  constructor: (@view, @app)->
    super
    console.log @DT, "Init."

    @assetListContainer = @view.find("[asset-list]")

    @btnPlaceAsset = @view.find("[place-asset]")

    @renderAssetsList()

    @drawPlaceButtonState()

    @interactionPlaceAssetBtnClick()

    $(@app.data)
      .asEventStream(@app.data.s.I_DATA_CHANGED)
      .filter((v)-> v.key == "selected-cell")
      .onValue @drawPlaceButtonState


  # Section: Interactions

  interactionPlaceAssetBtnClick: =>
    @btnPlaceAsset.asEventStream("click")
      .onValue =>
        selected = @assetListContainer.find("[name=asset]:checked")


  # Section: Draw

  drawPlaceButtonState: =>
    if @app.data.get("selected-cell")?
      @btnPlaceAsset.attr("disabled", null)
    else
      @btnPlaceAsset.attr("disabled", true)


  # Section: Render

  renderAssetsList: =>
    selected = true
    for asset in data.Assets
      @assetListContainer.append @templateAssetListItem(asset, selected)
      selected = false


  # Section: Templates

  # @param {dataTypes.AssetEntry} asset
  # @param {Boolean} selected
  # @return {String}
  templateAssetListItem: (asset, selected)=>
    id = "place-asset-#{asset.id}"
    selected = if selected then "checked" else ""
    """
      <div class="radio">
        <label for="#{id}">
          <input type="radio" name="asset" class="list-group-item" id="#{id}" #{selected}>
          #{asset.name}
        </label>
      </div>
    """