

$ ->

  $('#modalSave').on 'shown.bs.modal', ->
    $("#modalSave #levelJson").text JSON.stringify(window.level)