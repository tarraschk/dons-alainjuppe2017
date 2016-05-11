ready = ->
  $("#montants").find(".btn:not(.autre)").on 'click', ->
    montant = $(this).children("input").data("montant")
    changerValeurs(montant)
    return
  $("#montants").find(".btn.autre").on 'click', ->
    montant = $(this).children("input").data("montant")
    changerValeurs(montant)
    return
  $("#montant-autre-saisie").on 'keyup', ->
    montant = $(this).val()
    changerValeurs(montant)
    return

changerValeurs = (montant) ->
  montant = parseFloat(montant)
  if isNaN(montant)
    montant = 20
  $(".montant-don").text(montant+"€")
  $(".montant-don").val(montant)
  $(".montant-don-reduit").text((parseFloat(montant)*0.34).toFixed(2)+"€")
  return

$(document).ready(ready)
$(document).on('page:load', ready)