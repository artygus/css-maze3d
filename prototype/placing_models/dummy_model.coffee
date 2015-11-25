###
  Dummy model for test
###

class window.DummyModel

  DT: "DummyModel"

  constructor: ->

  getTemplate: =>
    """
      <div class="model-cl model-sample planes-container">

        <div class="model-sample__head planes-container">
          <div class="plane plane-front"></div>
          <div class="plane plane-back"></div>
          <div class="plane plane-top"></div>
          <div class="plane plane-bottom"></div>
          <div class="plane plane-right"></div>
          <div class="plane plane-left"></div>
        </div>

        <div class="model-sample__body planes-container">
          <div class="plane plane-front -big"></div>
          <div class="plane plane-back -big"></div>
          <div class="plane plane-top -small"></div>
          <div class="plane plane-bottom -small"></div>
          <div class="plane plane-right -side"></div>
          <div class="plane plane-left -side"></div>
        </div>

        <div class="model-sample__hand -left planes-container">
          <div class="plane plane-front -big"></div>
          <div class="plane plane-back -big"></div>
          <div class="plane plane-top -small"></div>
          <div class="plane plane-bottom -small"></div>
          <div class="plane plane-right -big"></div>
          <div class="plane plane-left -big"></div>
        </div>

        <div class="model-sample__hand -right planes-container">
          <div class="plane plane-front -big"></div>
          <div class="plane plane-back -big"></div>
          <div class="plane plane-top -small"></div>
          <div class="plane plane-bottom -small"></div>
          <div class="plane plane-right -big"></div>
          <div class="plane plane-left -big"></div>
        </div>

        <div class="model-sample__leg -left planes-container">
          <div class="plane plane-front -big"></div>
          <div class="plane plane-back -big"></div>
          <div class="plane plane-top -small"></div>
          <div class="plane plane-bottom -small"></div>
          <div class="plane plane-right -big"></div>
          <div class="plane plane-left -big"></div>
        </div>

        <div class="model-sample__leg -right planes-container">
          <div class="plane plane-front -big"></div>
          <div class="plane plane-back -big"></div>
          <div class="plane plane-top -small"></div>
          <div class="plane plane-bottom -small"></div>
          <div class="plane plane-right -big"></div>
          <div class="plane plane-left -big"></div>
        </div>

      </div>
    """