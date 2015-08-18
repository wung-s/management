$(document).on('page:change', function() {
  //destroy any datatable created earlier prior to creating a new one
  $('#students-table').dataTable().fnDestroy();

  $('#students-table').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#students-table').data('source'),
    "pagingType": "full_numbers",
    // optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
}); 