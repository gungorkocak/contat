
jQuery ->

  ###
    Perform importing contacts.
    
    File input and its form are hidden.
    Import Contact dropdown link delegates to file_select.
    After file selected, it will be posted to import_contacts_path automatically.
  ###

  $("input#contacts").change ->
    $("#import-contacts-submit").trigger("click")

  
  $("#import-contacts-link").on "click", (e) ->
    e.preventDefault()
    $("input#contacts").trigger("click")

