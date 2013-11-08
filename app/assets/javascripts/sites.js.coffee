jQuery ->
  $('#site_user_ids').chosen()
  $('#site_application_server_ids').chosen()
  $('#site_database_ids').chosen()
  $('#sites').dataTable
    "bPaginate": false,
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap"