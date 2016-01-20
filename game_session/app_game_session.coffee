###
  Game session controls interactions between render, game logic, controls, etc.
###

class gameSession.App extends abstract.Object

  DT: "gameSession.App"

  constructor: ->
    super
    @gl = new gameLogic.App()


  # section: Initializers

  initRender: =>
    unit = 100
    worldEl = document.getElementById('world')
    cameraEl = document.getElementById('camera')
    viewportEl = document.getElementById('viewport')
    @render = new Renderer(worldEl, unit)
    @camera = new GameCamera(viewportEl, worldEl, cameraEl, unit)

  initControls: =>
    keyboardJS.bind "w", (e)=>
      @gl.player.actionMoveForward()

    keyboardJS.bind "s", (e)=>
      @gl.player.actionMoveBackward()

    keyboardJS.bind "a", (e)=>
      @gl.player.actionStrafeLeft()

    keyboardJS.bind "d", (e)=>
      @gl.player.actionStrafeRight()

    keyboardJS.bind "q", (e)=>
      @gl.player.actionTurnAntiClockwise()

    keyboardJS.bind "e", (e)=>
      @gl.player.actionTurnClockwise()

    keyboardJS.bind "space", (e)=>
      @gl.player.actionAttack()

  linkGameLogicToRender: =>
    actors = @gl.world.data.get("actors")
    sActorsChanged = $(actors)
      .asEventStream(actors.s.I_DATA_CHANGED)

    sActorsChanged
      .filter((v)=> v.key == "mdata")
      .onValue => setTimeout @cameraUpdate, 1

    $(actors)
      .asEventStream(actors.tobject.s.I_DATA_DELETED)
      .onValue (v)=>
        @render.removeModel v.deleted.actor.getModel().get()[0]


  # section: Getters & setters

  # @param {dataTypes.level}
  setLevel: (level)=>
    @level = level


  # section: Loaders

  # Load given level geometry
  loadLevelGeometry: =>
    @gl.world.load @level.geometry

  # Load given actors collection to a current level
  loadLevelActors: =>
    for entry in @level.actors
      actor = @gl.createActorById entry.actor
      @gl.world.placeActor entry.cell, actor, entry.dir


  # section: Render

  renderLevelGeometry: =>
    @render.cells @level.geometry

  renderLevelActors: =>
    for actor in @gl.world.getActors()
      pos = actor.getPosition()
      model = actor.getModel().get()

      if model?
        @render.modelPlace model, pos.cell, pos.dir


  # section: Camera

  cameraUpdate: =>
    pos = @gl.world.data.get("actors").getDataByEntity(@gl.player)

    @camera.setCell pos.cell[0], pos.cell[1]
    @camera.setDirection pos.dir

    @camera.camera.update()


  # section: Main
  start: =>
    @initRender()
    @initControls()

    @loadLevelGeometry()
    @loadLevelActors()

    @renderLevelGeometry()
    @renderLevelActors()

    @linkGameLogicToRender()

    @cameraUpdate()
    @gl.time.create()





