###
  Actors on level
###

class levelEditor.data.LevelActors extends chms.ard.AbstractReactiveData

  DT: "levelEditor.data.LevelActors"

  init: =>
    super

    @set "actors", []

  # @param {dataTypes.ActorPosition} actorpos
  placeActor: (actorpos)=>
    unless @isAnyActorOnCell(actorpos.cell)
      @tarray.push "actors", actorpos
    else
      console.warn @DT, "placeActor: Actor already exists on " + actorpos.cell

  # @retun {Boolean}
  isAnyActorOnCell: (cell)=>
    @get("actors").reduce(
      (acc, cur)=> dataTypes.WorldCell.isEqual(cur.cell, cell)
      false
    )

