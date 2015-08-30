###
  Abstract actor
###

class gameLogic.actors.AbstractActor extends gameLogic.Object

  @UID_KEY: "actor"

  constructor: ->
    super

    @id = chms.utils.Uniq.gen @s.UID_KEY

    @data = new gameLogic.data.Actor()

    $(@data).asEventStream(@data.s.I_DATA_CHANGED)
      .filter((v)=> v.key == "inCharge")
      .onValue @act


  # section: Turns

  # Actors turn started
  turnStart: =>
    @data.set "inCharge", true

  # Actors turn ended
  turnEnded: =>
    @data.set "inCharge", false


  # section: Acting

  performAction: (action)=>
    @assureActorInCharge()

    action()

  actionNoop: =>
    @performAction @reactActionCompleted

  act: =>


  # section: Reactions

  @I_ACTION_COMPLETED: "action_completed"

  # Action completed
  reactActionCompleted: =>
    $(@).trigger @s.I_ACTION_COMPLETED


  # section: Helpers

  @E_ACTOR_NOT_IN_CHARGE: new Error("Actor does not in charge!")

  assureActorInCharge: =>
    unless @data.get "inCharge"
      throw @s.E_ACTOR_NOT_IN_CHARGE


