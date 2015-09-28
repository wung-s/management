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
  
  //always reset the selected option if country is NOT India
  if($("#student_country_id option:selected" ).text() != 'India') {
    $("#student_state_id option:first").val(); 
  }

  $('#new_student').change(function() {
    if($("#student_country_id option:selected" ).text() == 'India') {
        $("#student_state_id").removeAttr('disabled');
        $("#student_state_id").attr('required','required');
        $("#student_state_label").addClass('required');
    }else {
        $("#student_state_id").attr('disabled', 'true');
        $("#student_state_id").removeAttr('required');
        $("#student_state_label").removeClass('required');

    }
      

  });

  
}); 