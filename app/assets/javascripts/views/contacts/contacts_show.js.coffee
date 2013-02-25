class Contat.Views.ContactShow extends Backbone.View

  template: JST['contacts/show']

  id:       'container'


  events:
    "change input[type=text]":   "updateContact"
    "keypress input[type=text]": "detectEnter"


  initialize: =>
    @model.on "reset", @render


  render: =>
    $(@el).html( @template( contact: @model ) )
    $("#contact-show").html( @el )

    this
  

  detectEnter: (e) =>
    @updateContact(e) if e.which is 13


  updateContact: (e) =>
    console.log "updating contact, key, value:", $(e.currentTarget).attr('id'), $(e.currentTarget).val()
    id = $(e.currentTarget).attr('id')
    @setLoadingFor(id)
    
    @model.save id, $(e.currentTarget).val(),
      success: =>
        @setSuccessFor(id)

      error: (model, xhr, options) => 
        console.log "error updating. model, xhr, options", model, xhr, options
        @placeErrorTexts($.parseJSON(xhr.responseText))
        @setErrorFor(id)


  resetStatusFor: (id, time = 3000) =>
    callback = =>
      $(".item.#{id} .status").css("color", "")
      $(".item.#{id} .status").css("visibility", "")
      $(".item.#{id} .status").toggleClass("icon-ok", false)
      $(".item.#{id} .status").toggleClass("icon-minus", false)
      $(".item.#{id} .status").toggleClass("icon-edit", true)

    setTimeout callback, time


  setLoadingFor: (id) =>
    $(".item.#{id} .status").toggleClass("icon-spinner", true)
    $(".item.#{id} .status").toggleClass("icon-edit", false)
    $(".item.#{id} .status").toggleClass("icon-spin", true)
    $(".item.#{id} .status").css("visibility", "visible")
    $(".item.#{id} .status").css("color", "#963")

    $(".item .error").text("")


  setSuccessFor: (id) =>
    $(".item.#{id} .status").toggleClass("icon-spinner", false)
    $(".item.#{id} .status").toggleClass("icon-spin", false)
    $(".item.#{id} .status").toggleClass("icon-ok", true)
    $(".item.#{id} .status").css("color", "#696")

    @resetStatusFor(id) 


  setErrorFor: (id) =>
    $(".item.#{id} .status").toggleClass("icon-spinner", false)
    $(".item.#{id} .status").toggleClass("icon-spin", false)
    $(".item.#{id} .status").toggleClass("icon-minus", true)
    $(".item.#{id} .status").css("color", "#943")

    @resetStatusFor(id, 7000) 

  placeErrorTexts: (hash = {}) =>
    console.log "got errors as: ", hash
    for key, value of hash.errors
      console.log "placing errors, key, value", key, value
      $(".item.#{key} .error").text(value[0])
