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
  isAnyActorOnCell: (cell)=> @getActorOnCell(cell)?

  # @return {dataTypes.ActorPosition|null}
  getActorOnCell: (cell)=>
    actor = @get("actors").filter(
      (cur)=> dataTypes.Pos.isEqual(cur.cell, cell)
    )

    if actor.length == 1
      return actor[0]
    else if actor.length > 1
      throw "#{@DT}: There are 2 or more actors at one cell!"
    else
      return null

