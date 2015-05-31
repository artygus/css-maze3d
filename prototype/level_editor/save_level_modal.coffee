

$ ->

  $('#modalSave').on 'shown.bs.modal', ->
    $("#modalSave [name='levelJson']").text JSON.stringify(window.level)