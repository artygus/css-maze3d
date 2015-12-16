###
  Abstract model
###

# TODO: global obj
class models.Abstract extends abstract.Object

  DT: "models.Abstract"

  constructor: ->
    super

    @initAnimationsDictionary()


  # section: Init

  initAnimationsDictionary: =>
    @_animations = {}


  # section: Template & rendering

  # Get rendered model
  # @return {jQuery}
  get: =>
    unless @_rendered?
      @_rendered = $ @getTemplate()

    return @_rendered

  # @return {String}
  getTemplate: => ""


  # section: Animations

  # @return {Integer} Pause time
  animate: (actionId)=>
    if (ad = @_animations[actionId])?
      return @animateBasic ad.cl, ad.time
    else
      return 0

  animateBasic: (cl, time)=>
    el = @get()
    el.addClass cl

    setTimeout (-> el.removeClass(cl)), time

    return time

