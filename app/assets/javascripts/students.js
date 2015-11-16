$(document).ready(function() {
  $('#edit_button').click(function() {
    $('#student_info_wrapper').attr('style', 'display: none');
    $('#student_form_wrapper').attr('style', 'display: block');
    //$(this).attr('style', 'display: none');
  });

  //always reset the selected option if country is NOT India
  $('#student_country_id').change(function() {
    alert('changed');
    if($("#student_country_id option:selected" ).text() != 'India') {
      $("#student_state_id option:first").val();
    }
  });



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