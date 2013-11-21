jQuery ->
  $('#server_site_ids').chosen()
  if $('#current_user').data("logged_in")
    $.getScript('/users/current')
  $('.datatable').dataTable
    "bPaginate": false,
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap"