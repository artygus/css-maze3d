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

  # @param {dataTypes.ActorPosition} actorpos
  updateActor: (actorpos)=>
    @removeActor(actorpos.cell)
    @placeActor(actorpos)

  # @param {dataTypes.Pos} pos
  removeActor: (pos)=>
    if (i = @findActorIndexByPos(pos)) > -1
      @tarray.delete "actors", i
    else
      throw "#{@DT}: Actor not exist on a given cell #{actorpos.cell}"

  # @retun {Boolean}
  isAnyActorOnCell: (cell)=> @getActorOnCell(cell)?

  # @return {dataTypes.ActorPosition|null}
  getActorOnCell: (cell)=>
    if (i = @findActorIndexByPos(cell)) > -1
      @get("actors")[i]
    else
      null

  # @param {dataTypes.Pos} pos
  # @return {Int}
  findActorIndexByPos: (pos)=>
    res = @get("actors")
      .map((e, i)-> [e, i])
      .filter (e)-> dataTypes.Pos.isEqual(e[0].cell, pos)

    if res.length == 1
      return res[0][1]
    else if res.length == 0
      return -1
    else
      throw "#{@DT}: There are two or more actor on a given pos #{pos}"




