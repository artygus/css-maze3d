###
  Faces editor
###

class window.FacesEditor

  constructor: (@el)->
    @s = @constructor

    @isouth = @el.find "#faceSouth"
    @ieast = @el.find "#faceEast"
    @inorth = @el.find "#faceNorth"
    @iwest = @el.find "#faceWest"

    @fdict = {
      s: @isouth
      e: @ieast
      n: @inorth
      w: @iwest
    }

    @bupdate = @el.find "[update]"
    @bupdate.on "click", @update

  update: =>
    selected = $("[cell].-selected")

    for cell in selected
      cell = $ cell
      xy = getXYfromCell cell
      ci = getIndex xy.x, xy.y

      cell.addClass "level-cell"

      level[ci] = makeCell(xy.x, xy.y)

      for key, input of @fdict
        if input.val() != ""
          level[ci][key] = {
            face: input.val()
            type: 'wall'
          }






