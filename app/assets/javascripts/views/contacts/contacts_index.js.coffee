class Contat.Views.ContactsIndex extends Backbone.View

  template: JST['contacts/index']

  tagName: 'ul'
  id:      'contacts'


  initialize: =>
    @collection.on "reset", @render
    @collection.on "add",   @render
    
    $(".contacts-add.btn").on "click", @renderNew


  render: =>
    $(@el).html( @template() )
    $("ul#contacts").replaceWith( @el )

    @collection.each( @appendContact )

    this


  appendContact: (contact) =>
    view = new Contat.Views.Contact( model: contact )
    $(@el).append(view.render().el)
    

  renderNew: (e) =>
    app.navigate "new", true

