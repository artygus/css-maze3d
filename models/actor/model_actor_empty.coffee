###
  Empty actor model
###

class models.actors.Empty extends models.actors.Abstract

  DT: "models.actors.Empty"

  # @return {String}
  getTemplate: =>
    """
      <div class="model-empty" style="display: none"></div>
    """

