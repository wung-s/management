$(document).ready(function() {

  check_for_select_option();
  check_nationality_and_state();

  $('#edit_button').click(function() {
    $('#student_info_wrapper').attr('style', 'display: none');
    $('#student_form_wrapper').attr('style', 'display: block');
    check_nationality_and_state();


  });

  //always reset the selected option if country is NOT India
  $('#student_country_id').change(function() {
    if($("#student_country_id option:selected" ).text() != 'India') {
      $("#student_state_id option").removeAttr("selected");
    }
    check_nationality_and_state();
  });

  $('#new_student').change(function() {
    check_nationality_and_state();
  });

  function check_nationality_and_state() {
    if($("#student_country_id option:selected" ).text() == 'India') {
        $("#student_state_id").removeAttr('disabled');
        $("#student_state_id").attr('required','required');
        $("#student_state_label").addClass('required');

    }else {
        $("#student_state_id").attr('disabled', 'true');
        $("#student_state_id").removeAttr('required');
        $("#student_state_label").removeClass('required');

    }
 }

  function check_for_select_option() {
    select_exist = false;
    $("#student_state_id option").each(function() {
      if(this.value == ''){
        select_exist = true;
      }
    });

    if(!select_exist)
      $('#student_state_id').prepend('<option value="">Select State</option>');
  }
});

