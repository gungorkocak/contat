class Contat.Views.Contact extends Backbone.View

  template:  JST['contacts/contact']

  tagName:   'li'
  className: 'contact'

  events:
    'click': 'showContact' 
  
  initialize: =>
    @model.on "change", @render

  render: =>
    @setProperTag()
    $(@el).html( @template(contact: @model) )

    this
  

  setProperTag: ->
    $(@el).attr('id', "contact-#{@model?.get("id")}")
    $(@el).data('id', @model?.get('id'))


  showContact: (e) =>
    app.navigate "/#{@model.get('id')}", true
