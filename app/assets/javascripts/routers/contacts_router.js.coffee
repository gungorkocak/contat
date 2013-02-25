class Contat.Routers.Contacts extends Backbone.Router

  ###
    This is the main router.

    Routes:
      /    -> index page to list all of the initial contact list.
      /new -> new page to create a new contact.
      /:id -> show page to show details of a contact.
  ###

  routes:
    '':     'index'
    'new':  'newContact'
    ':id':  'show'

  index: ->
    @fetchContacts()
    @index_view   = new Contat.Views.ContactsIndex(collection: @collection)

    @index_view.render()


  fetchContacts: ->
    @collection ||= new Contat.Collections.Contacts
    @collection.fetch()

  show: (id) ->
    @index()

    @collection.on "reset", =>
      @model = @collection.get(id)

      @show_view = new Contat.Views.ContactShow(model: @model)
      @show_view.render()


  newContact: ->
    @fetchContacts()

    @new_view = new Contat.Views.ContactNew(collection: @collection)

