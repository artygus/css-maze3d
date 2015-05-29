###
  Actor class
###

class window.Actor

  I_ACTION_COMPLETED: "action_completed"

  I_MOVED: "moved"

  # section: Interaction

  # Called when actor need perform an action
  act: => @noop()

  # section: Actions

  # Noop action
  noop: =>
    @reactActionCompleted()

  # Move action
  move: =>
    @reactActionCompleted()


  # section: World

  place: (world, x, y, d)=>
    world.addEntity @

  # React

  reactActionCompleted: =>
    $(@).trigger @I_ACTION_COMPLETED



