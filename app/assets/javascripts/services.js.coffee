jQuery ->
  $('#service_user_ids').chosen()
	$('#services').dataTable( {"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>", "aoColumnDefs": [ { "bSortable": false, "aTargets": [ 1, 4, 5, 6, 7 ] } ] })