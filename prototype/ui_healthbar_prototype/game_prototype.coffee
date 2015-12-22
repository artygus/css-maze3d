###
  Game class prototype
###

class window.GamePrototype

  DT: "GamePrototype"

  constructor: ->
    @gl = new gameLogic.App()
    @initRender()
    @initUI()


  # section: Initializers

  initUI: =>
    new UIPrototype(@gl)


  initRender: =>
    unit = 100
    worldEl = document.getElementById('world')
    cameraEl = document.getElementById('camera')
    viewportEl = document.getElementById('viewport')
    @render = new Renderer(worldEl, unit)
    @camera = new GameCamera(viewportEl, worldEl, cameraEl, unit)

  # TODO: module
  initKeyboard: =>
    keyboardJS.bind "w", (e)=>
      # TODO: bug somewhere
      @gl.player.actionMoveForward()

    keyboardJS.bind "s", (e)=>
      # TODO: bug somewhere
      @gl.player.actionMoveBackward()

    keyboardJS.bind "a", (e)=>
      @gl.player.actionStrafeLeft()

    keyboardJS.bind "d", (e)=>
      @gl.player.actionStrafeRight()

    keyboardJS.bind "q", (e)=>
      # TODO: bug somewhere
      @gl.player.actionTurnAntiClockwise()

    keyboardJS.bind "e", (e)=>
      # TODO: bug somewhere
      @gl.player.actionTurnClockwise()

    keyboardJS.bind "space", (e)=>
      @gl.player.actionAttack()


  # section: Loaders

  # Load given level geometry
  loadLevelGeometry: (geometry)=>
    @gl.world.load geometry

  # Load given actors collection to a current level
  loadActorsCollection: (actors)=>
    for entry in actors
      @gl.world.placeActor entry.cell, entry.actor, entry.dir

  # Load given level container
  loadLevel: (levelContainer)=>
    @loadLevelGeometry levelContainer.geometry
    @loadActorsCollection levelContainer.actors


  # section: Render

  # TODO: proper data type
  renderLevelGeometry: =>
    @render.cells @getTestLevelGeometry()

  renderActorsModels: =>
    for actor in @gl.world.getActors()
      pos = actor.getPosition()
      model = actor.getModel().get()

      if model?
        @render.modelPlace model, pos.cell, pos.dir


  # section: Camera

  cameraUpdate: =>
    pos = @gl.world.data.get("actors").getDataByEntity(@gl.player)

    @camera.set pos.cell[0], pos.cell[1], pos.dir
    @camera.camera.update()


  # section: Main

  start: =>
    @renderLevelGeometry()
    @renderActorsModels()
    @cameraUpdate()
    @gl.time.create()

    # TODO: org
    @initKeyboard()

    # TODO: org
    actors = @gl.world.data.get("actors")
    sActorsChanged = $(actors)
      .asEventStream(actors.s.I_DATA_CHANGED)

    sActorsChanged
      .filter((v)=> v.key == "mdata")
      .onValue =>
        setTimeout @cameraUpdate, 1

    $(actors)
      .asEventStream(actors.tobject.s.I_DATA_DELETED)
      .onValue (v)=>
        @render.removeModel v.deleted.actor.getModel().get()[0]


  # section: helpers

  getTestLevelGeometry: =>
    {"222x208":{"x":222,"y":208,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"222x209":{"x":222,"y":209},"222x210":{"x":222,"y":210,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"221x209":{"x":221,"y":209,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"223x209":{"x":223,"y":209,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"221x211":{"x":221,"y":211,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"220x211":{"x":220,"y":211,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"222x211":{"x":222,"y":211,"s":{"face":"black-wall","type":"wall"}},"223x211":{"x":223,"y":211,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"224x211":{"x":224,"y":211,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x211":{"x":219,"y":211,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"219x212":{"x":219,"y":212,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x213":{"x":219,"y":213,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x214":{"x":219,"y":214,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"220x214":{"x":220,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"221x214":{"x":221,"y":214,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"221x213":{"x":221,"y":213,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"222x213":{"x":222,"y":213,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"223x213":{"x":223,"y":213,"n":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"223x214":{"x":223,"y":214,"w":{"face":"black-wall","type":"wall"}},"223x215":{"x":223,"y":215,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"223x216":{"x":223,"y":216,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"222x216":{"x":222,"y":216,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"221x216":{"x":221,"y":216,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"220x216":{"x":220,"y":216,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"219x216":{"x":219,"y":216,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"219x217":{"x":219,"y":217,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x218":{"x":219,"y":218},"218x218":{"x":218,"y":218,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"220x218":{"x":220,"y":218,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x219":{"x":219,"y":219,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x220":{"x":219,"y":220,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"219x221":{"x":219,"y":221,"s":{"face":"black-wall","type":"wall"}},"218x221":{"x":218,"y":221,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"220x221":{"x":220,"y":221,"n":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"217x222":{"x":217,"y":222,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"217x223":{"x":217,"y":223,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"218x222":{"x":218,"y":222,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"221x222":{"x":221,"y":222,"n":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"221x223":{"x":221,"y":223,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"220x224":{"x":220,"y":224,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"219x224":{"x":219,"y":224,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"218x224":{"x":218,"y":224,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"220x222":{"x":220,"y":222,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"217x224":{"x":217,"y":224,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"221x224":{"x":221,"y":224,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"224x214":{"x":224,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"225x214":{"x":225,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"226x214":{"x":226,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"228x214":{"x":228,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"227x214":{"x":227,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"229x214":{"x":229,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"230x214":{"x":230,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"232x214":{"x":232,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"231x214":{"x":231,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"233x214":{"x":233,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"235x214":{"x":235,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"234x214":{"x":234,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"236x214":{"x":236,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"237x214":{"x":237,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"238x214":{"x":238,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"239x214":{"x":239,"y":214,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"240x214":{"x":240,"y":214},"241x214":{"x":241,"y":214},"242x214":{"x":242,"y":214,"e":{"face":"black-wall","type":"wall"}},"240x213":{"x":240,"y":213,"w":{"face":"black-wall","type":"wall"}},"240x212":{"x":240,"y":212,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"241x212":{"x":241,"y":212,"n":{"face":"black-wall","type":"wall"}},"242x212":{"x":242,"y":212,"n":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"242x213":{"x":242,"y":213,"e":{"face":"black-wall","type":"wall"}},"241x213":{"x":241,"y":213},"240x215":{"x":240,"y":215,"w":{"face":"black-wall","type":"wall"}},"241x215":{"x":241,"y":215},"242x215":{"x":242,"y":215,"e":{"face":"black-wall","type":"wall"}},"242x216":{"x":242,"y":216,"s":{"face":"black-wall","type":"wall"}},"241x216":{"x":241,"y":216,"s":{"face":"black-wall","type":"wall"}},"240x216":{"x":240,"y":216,"s":{"face":"black-wall","type":"wall"}},"239x216":{"x":239,"y":216,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"238x216":{"x":238,"y":216,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"238x217":{"x":238,"y":217,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"238x218":{"x":238,"y":218,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"239x218":{"x":239,"y":218,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"240x218":{"x":240,"y":218,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"241x218":{"x":241,"y":218,"n":{"face":"black-wall","type":"wall"}},"242x218":{"x":242,"y":218,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"243x218":{"x":243,"y":218,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"243x217":{"x":243,"y":217,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"243x216":{"x":243,"y":216,"n":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"241x219":{"x":241,"y":219,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"241x220":{"x":241,"y":220,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"241x221":{"x":241,"y":221,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"241x222":{"x":241,"y":222,"w":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"241x223":{"x":241,"y":223,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"240x223":{"x":240,"y":223,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"239x223":{"x":239,"y":223,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"238x223":{"x":238,"y":223,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"237x223":{"x":237,"y":223,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"236x223":{"x":236,"y":223,"n":{"face":"black-wall","type":"wall"},"s":{"face":"black-wall","type":"wall"}},"235x223":{"x":235,"y":223,"s":{"face":"black-wall","type":"wall"}},"235x222":{"x":235,"y":222,"e":{"face":"black-wall","type":"wall"}},"235x221":{"x":235,"y":221,"e":{"face":"black-wall","type":"wall"}},"235x220":{"x":235,"y":220,"e":{"face":"black-wall","type":"wall"}},"235x219":{"x":235,"y":219,"e":{"face":"black-wall","type":"wall"}},"235x218":{"x":235,"y":218,"e":{"face":"black-wall","type":"wall"}},"235x217":{"x":235,"y":217,"e":{"face":"black-wall","type":"wall"}},"235x216":{"x":235,"y":216,"n":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"234x216":{"x":234,"y":216,"n":{"face":"black-wall","type":"wall"}},"233x216":{"x":233,"y":216,"n":{"face":"black-wall","type":"wall"}},"232x216":{"x":232,"y":216,"n":{"face":"black-wall","type":"wall"}},"231x216":{"x":231,"y":216,"n":{"face":"black-wall","type":"wall"}},"230x216":{"x":230,"y":216,"n":{"face":"black-wall","type":"wall"}},"230x217":{"x":230,"y":217},"229x216":{"x":229,"y":216,"n":{"face":"black-wall","type":"wall"}},"229x217":{"x":229,"y":217},"229x218":{"x":229,"y":218},"229x219":{"x":229,"y":219},"229x220":{"x":229,"y":220},"229x222":{"x":229,"y":222},"229x223":{"x":229,"y":223},"229x224":{"x":229,"y":224},"229x225":{"x":229,"y":225},"229x226":{"x":229,"y":226,"s":{"face":"black-wall","type":"wall"}},"230x226":{"x":230,"y":226,"s":{"face":"black-wall","type":"wall"}},"231x226":{"x":231,"y":226,"s":{"face":"black-wall","type":"wall"}},"232x226":{"x":232,"y":226,"s":{"face":"black-wall","type":"wall"}},"233x226":{"x":233,"y":226,"s":{"face":"black-wall","type":"wall"}},"234x225":{"x":234,"y":225,"e":{"face":"black-wall","type":"wall"}},"234x226":{"x":234,"y":226,"s":{"face":"black-wall","type":"wall"},"e":{"face":"black-wall","type":"wall"}},"234x224":{"x":234,"y":224,"e":{"face":"black-wall","type":"wall"}},"234x223":{"x":234,"y":223},"233x225":{"x":233,"y":225},"233x224":{"x":233,"y":224},"233x223":{"x":233,"y":223},"232x225":{"x":232,"y":225},"232x224":{"x":232,"y":224},"231x225":{"x":231,"y":225},"231x224":{"x":231,"y":224},"231x223":{"x":231,"y":223},"230x223":{"x":230,"y":223},"230x225":{"x":230,"y":225},"230x224":{"x":230,"y":224},"229x221":{"x":229,"y":221},"230x222":{"x":230,"y":222},"231x222":{"x":231,"y":222},"232x222":{"x":232,"y":222},"232x223":{"x":232,"y":223},"233x222":{"x":233,"y":222},"234x222":{"x":234,"y":222},"234x221":{"x":234,"y":221},"234x220":{"x":234,"y":220},"233x221":{"x":233,"y":221},"232x221":{"x":232,"y":221},"231x221":{"x":231,"y":221},"230x221":{"x":230,"y":221},"230x220":{"x":230,"y":220},"231x220":{"x":231,"y":220},"232x220":{"x":232,"y":220},"233x220":{"x":233,"y":220},"233x219":{"x":233,"y":219},"234x219":{"x":234,"y":219},"232x219":{"x":232,"y":219},"231x219":{"x":231,"y":219},"230x219":{"x":230,"y":219},"230x218":{"x":230,"y":218},"231x218":{"x":231,"y":218},"232x218":{"x":232,"y":218},"233x218":{"x":233,"y":218},"234x218":{"x":234,"y":218},"234x217":{"x":234,"y":217},"233x217":{"x":233,"y":217},"232x217":{"x":232,"y":217},"231x217":{"x":231,"y":217},"228x226":{"x":228,"y":226,"s":{"face":"black-wall","type":"wall"}},"228x225":{"x":228,"y":225},"228x224":{"x":228,"y":224},"228x223":{"x":228,"y":223},"228x222":{"x":228,"y":222},"228x221":{"x":228,"y":221},"228x220":{"x":228,"y":220},"228x219":{"x":228,"y":219},"228x218":{"x":228,"y":218},"228x217":{"x":228,"y":217},"228x216":{"x":228,"y":216,"n":{"face":"black-wall","type":"wall"}},"227x216":{"x":227,"y":216,"n":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}},"227x217":{"x":227,"y":217,"w":{"face":"black-wall","type":"wall"}},"227x219":{"x":227,"y":219,"w":{"face":"black-wall","type":"wall"}},"227x218":{"x":227,"y":218,"w":{"face":"black-wall","type":"wall"}},"227x220":{"x":227,"y":220,"w":{"face":"black-wall","type":"wall"}},"227x221":{"x":227,"y":221,"w":{"face":"black-wall","type":"wall"}},"227x222":{"x":227,"y":222,"w":{"face":"black-wall","type":"wall"}},"227x223":{"x":227,"y":223,"w":{"face":"black-wall","type":"wall"}},"227x224":{"x":227,"y":224,"w":{"face":"black-wall","type":"wall"}},"227x225":{"x":227,"y":225,"w":{"face":"black-wall","type":"wall"}},"227x226":{"x":227,"y":226,"s":{"face":"black-wall","type":"wall"},"w":{"face":"black-wall","type":"wall"}}}

  getTestActorCollection: =>
    [
      dataTypes.ActorPosition.get(@gl.player, [222, 209], dataTypes.WorldDirection.S)
      dataTypes.ActorPosition.get(new gameLogic.actors.Dummy(@gl), [222, 210], dataTypes.WorldDirection.N)
    ]

  getTestLevelContainer: =>
    {
      geometry: @getTestLevelGeometry()
      actors: @getTestActorCollection()
    }

  # TODO: models storage
  getModelForActor: (actor)=>
    if actor == @gl.player
      return undefined
    else
      return new DummyModel()



