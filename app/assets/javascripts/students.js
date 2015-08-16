$(document).on('page:change', function() {
  //console.log('page changed on page js file'); 
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