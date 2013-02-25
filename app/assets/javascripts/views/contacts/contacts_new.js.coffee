class Contat.Views.ContactNew extends Backbone.View

  template: JST['contacts/show']

  id:       'container'

  events:
    "click .submit.btn": "createContact"

  initialize: =>
    @collection.on "reset", @render
    @model = new Contat.Models.Contact


  render: =>
    console.log "rendering content"
    $(@el).html( @template(contact: @model) )
    $("#contact-show").html( @el )

    $(".submit.btn").on "click", @createContact 
    
    this


  createContact: (e) =>

    @resetErrorState()

    @model = new Contat.Models.Contact
      name:       $("#contact-form #name").val()
      last_name:  $("#contact-form #last_name").val()
      phone:      $("#contact-form #phone").val()


    @collection.create @model,
      wait: true
      
      success: (collection, response, options) =>
        console.log "after success: model, collection", @model, collection
        app.navigate "#{@model.get('id')}", true

      error: (collection, xhr, options) =>
        @placeErrorTexts($.parseJSON(xhr.responseText))


  placeErrorTexts: (hash = {}) =>
    for key, value of hash.errors
      console.log "placing errors, key, value", key, value
      $(".item.#{key} .error").text(value[0])
      $(".item.#{key} input").toggleClass("inline-error", true)


  resetErrorState: =>
    $(".item em.error").text('')
    $(".item input").toggleClass("inline-error", false)
    
