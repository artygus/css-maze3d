###
  Main editor data file
###

class levelEditor.data.Editor extends chms.ard.AbstractReactiveData

  DT: "levelEditor.data.Editor"

  constructor: ->
    super
    console.log @DT, "Init."

    @logicUpdateSelectedCellOnModeChanged()

  init: =>
    super

    @set "ui-modes", new levelEditor.data.UiModes()

    @set "level-cells", new levelEditor.data.LevelCells()

    @set "level-actors",  new levelEditor.data.LevelActors()

    @set "selected-cell", null


  # section: Logic

  logicUpdateSelectedCellOnModeChanged: =>
    $(@.get("ui-modes"))
      .asEventStream(@.s.I_DATA_CHANGED)
      .filter((v)-> v.key == "currentMode")
      .filter((v)=> v.value != @.get("ui-modes").s.MODE_SELECT)
      .onValue => @setIfUnequal "selected-cell", null


  # section: Actors

  # @param {dataTypes.ActorPosition} actorpos
  placeActor: (actorpos)=>
    if @get("level-cells").isCellBelongs(actorpos.cell)
      @get("level-actors").placeActor(actorpos)
    else
      throw "#{@DT}: cell #{actorpos.cell} does not belongs to level"


  # section: Cells

  # Remove cell from level
  # @param {dataTypes.Pos} pos
  removeCell: (pos)=>
    @get("level-cells").removeCell(pos)

    if @get("level-actors").isAnyActorOnCell(pos)
      @get("level-actors").removeActor(pos)

  # section: Helpers

  # @return {Boolean}
  isCellSelectedWithActor: =>
    s = @get("selected-cell")
    s? && @get("level-actors").getActorOnCell(s)?
