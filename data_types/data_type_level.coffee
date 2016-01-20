###
  Level container
###

dataTypes.Level =

  # @param {levelEditor.data.LevelCells} geometry
  # @param {Array.<dataTypes.ActorPosition>} actors
  # @return {dataTypes.Level}
  get: (geometry, actors)->
    {
      geometry: geometry
      actors: actors
    }
