window.Contat =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    window.app = new Contat.Routers.Contacts
    Backbone.history.start()

$(document).ready ->
  Contat.initialize()
