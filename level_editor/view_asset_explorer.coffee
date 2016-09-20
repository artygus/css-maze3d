###
  Asset explorer view
###

class levelEditor.view.AssetExplorer extends levelEditor.Object

  DT: "levelEditor.view.AssetExplorer"

  @VID: "view-leditor-asset-explorer"

  constructor: (@view, @app)->
    super
    console.log @DT, "Init."

    @renderAssetsList()


  # Section: Render

  renderAssetsList: =>
    container = @view.find("[asset-list]")

    for asset in data.Assets
      container.append @templateAssetListItem(asset)


  # Section: Templates

  # @param {dataTypes.AssetEntry} asset
  # @return {String}
  templateAssetListItem: (asset)=>
    id = "place-asset-#{asset.id}"
    """
      <div class="radio">
        <label for="#{id}">
          <input type="radio" name="asset" class="list-group-item" id="#{id}">
          #{asset.name}
        </label>
      </div>
    """