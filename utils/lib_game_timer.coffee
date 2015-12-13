###
  Game timer
###

# TODO: Root object
class utils.lib.GameTimer

  DT: "utils.lib.GameTimer"

  TICK_TIME: 10

  constructor: ->
    @_mainCounter = 0
    @_pauseCounter = 0


  # section: Timer

  tick: =>
    if @_mainCounter == 0
      clearInterval @_interval
      return

    if @isPaused()
      @_pauseCounter = Math.max 0, @_pauseCounter - @TICK_TIME
    else
      @_mainCounter = Math.max 0, @_mainCounter - @TICK_TIME

      if @_mainCounter == 0
        @_callback()
        @_callback = undefined
        clearInterval @_interval


  # section: Interface

  setTimeout: (fn, time)=>
    clearInterval @_interval
    @_callback = fn
    @_mainCounter = time
    @_interval = setInterval @tick, @TICK_TIME

  setPause: (ms)=>
    @_pauseCounter = ms

  isPaused: =>
    @_pauseCounter > 0

