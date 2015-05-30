###
  Player actor
###

class window.Player extends Actor

  DT: "Player"

  constructor: ->
    super
    @initKeyboardControls()


  act: =>
    super


  # section: Keyboard controls

  initKeyboardControls: =>

    $(document).on "keyup", (e)=>

      switch e.which

        when utils.KEY_UP, utils.KEY_DOWN
          console.log @DT, "Key up or down"
          cc = $.extend {}, @currentPosition
          v = utils.getVectorByKeyAndDirection(e.which, @currentPosition.d)
          cc[v.dim] += v.v
          @move cc

        when utils.KEY_LEFT
          console.log @DT, "Key left"
          @turn -1

        when utils.KEY_RIGHT
          console.log @DT, "Key right"
          @turn +1

        when utils.KEY_A
          console.log @DT, "Key A"
          @attack()


  # section: Combat mechanics

  # Current actor health
  HEALTH: 200

  # Max actor health
  MAX_HEALTH: 200

  # Actor damage
  DAMAGE: 20


