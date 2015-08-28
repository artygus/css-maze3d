###
  Character position data type
###

dataTypes.CharacterPosition =

  # @param {*} entity
  # @param {Cell} cell
  # @param {dataTypes.WorldDirection}
  get: (entity, cell, dir)=>
    return {character: entity, cell: cell, dir: dir, id: entity.id}
