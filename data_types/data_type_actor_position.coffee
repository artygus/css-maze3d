###
  Actor  position data type
###

dataTypes.ActorPosition =

  # @param {*} entity
  # @param {dataTypes.Pos} cell
  # @param {dataTypes.WorldDirection}
  get: (entity, cell, dir)=>
    return {actor: entity, cell: cell, dir: dir, id: entity.id}
