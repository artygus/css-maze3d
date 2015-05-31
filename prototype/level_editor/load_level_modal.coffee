
$ ->

  modal = $("#modalLoad")
  area = modal.find("[name='levelJson']")

  modal.find("button[load-level]").click (e)->
    level = area.val()

    if level.length > 0
      window.level = JSON.parse(level)
      window.drawLevel()
