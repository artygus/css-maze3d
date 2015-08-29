###
  Actor  position data type
###

dataTypes.ActorPosition =

  # @param {*} entity
  # @param {Cell} cell
  # @param {dataTypes.WorldDirection}
  get: (entity, cell, dir)=>
    return {actor: entity, cell: cell, dir: dir, id: entity.id}
