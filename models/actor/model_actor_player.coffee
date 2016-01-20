###
  Model for player actor
###

class models.actors.Player extends models.actors.Empty

  DT: "models.actors.Player"

  initAnimationsDictionary: =>
    @_animations = {
      move:
        cl: ""
        time: 500
    }