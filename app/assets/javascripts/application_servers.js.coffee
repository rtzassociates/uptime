jQuery ->
  $('#application_server_site_ids').chosen()
  $('#application_servers').dataTable
    "bPaginate": false,
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap"