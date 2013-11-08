jQuery ->
  $('#server_site_ids').chosen()
  if $('#logged_in')
    $.getScript('/users/current')