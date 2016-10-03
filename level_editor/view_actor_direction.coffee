###
  Actor direction view
###

class levelEditor.view.ActorDirection extends levelEditor.Object

  DT: "levelEditor.view.ActorDirection"

  @VID: "view-leditor-actor-direction"

  constructor: (@el, @app)->
    super
    console.log @DT, "Init."

    @logicUpdateDisableStateOnCellSelected()


  # section: Logic

  logicUpdateDisableStateOnCellSelected: =>
    updateState = (s)=>
      if s == null
        @stateNoCellSelected()
      else if (apos = @app.data.get("level-actors").getActorOnCell(s))?
        @stateActor(apos)
      else
        @stateNoActor()

    $(@app.data)
      .asEventStream(@app.data.s.I_DATA_CHANGED)
      .filter((v)-> v.key == "selected-cell")
      .onValue (v)=> updateState(v.value)

    updateState @app.data.get("selected-cell")


  # section: View

  getRadios: => @el.find("[type=radio]")

  disableWorldDirectionRadios: =>
    @el.addClass "-disabled"
    @getRadios().attr(disabled: true)

  enableWorldDirectionRadios: =>
    @el.removeClass "-disabled"
    @getRadios().attr(disabled: null)

  stateNoActor: =>
    @disableWorldDirectionRadios()
    @uncheckAllRadios()
    @setActorIdText("No actor")

  # @param {dataTypes.ActorPosition} apos
  stateActor: (apos)=>
    @enableWorldDirectionRadios()
    @setActorIdText("Actor#id")
    @checkRadioByDirection(apos.dir)

  stateNoCellSelected: =>
    @disableWorldDirectionRadios()
    @uncheckAllRadios()
    @setActorIdText("No cell")

  # @param {String}
  setActorIdText: (text)=>
    @el.find("[actor-id]").text(text)

  # @param {dataTypes.WorldDirection}
  getRadioByDirection: (dir)=>
    @el.find("#actor-direction-#{dir.toLowerCase()}")

  uncheckAllRadios: =>
    @getRadios().attr(checked: null)

  checkRadioByDirection: (dir)=>
    @uncheckAllRadios()
    @getRadioByDirection(dir).prop(checked: true)


