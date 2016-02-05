# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # init the baord
  if gon?
    for p in [1..9]
      if gon.game['board'][p] != false
        $(SymIcon(gon.game['board'][p].toLowerCase())).appendTo($("#cell-#{p}"))
