jQuery ->
  $('#server_site_ids').chosen()
  if $('#current_user').data("logged_in")
    $.getScript('/users/current')