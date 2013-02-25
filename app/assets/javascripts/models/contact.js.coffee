class Contat.Models.Contact extends Backbone.Model
  url: -> 
    url = "/api/contacts/"
    url = "#{url}/#{@get('id')}" if @get('id')
    url
