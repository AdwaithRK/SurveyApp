var optionsremoved = false;
$(document).on('turbolinks:load', function () {

  $('.change_type').each(function (e) {
    debugger
    if ($(this).val() == "text") {
      question_id = parseInt($(this).attr('data-question-id'))
      $("#changed_answer_for_question_" + question_id + "").empty().show()
      $("#changed_answer_for_question_" + question_id + "").append("<div><input type='text' value='' placeholder='text answer'  class='Answer_options_item' readonly /></div>");
    }
  })

  $('body').on("change", ".change_type", function () {
    option_value = $(this).val()
    question_id = parseInt($(this).attr('data-question-id'))
    debugger
    if (option_value == "text") {
      debugger
      $("#changed_answer_for_question_" + question_id + "").empty().show()
      $("#changed_answer_for_question_" + question_id + "").append("<div><input type='text' value='' placeholder='text answer'  class='Answer_options_item' readonly /></div>");
    } else {
      $("#changed_answer_for_question_" + question_id + "").empty().show()
      $("#changed_answer_for_question_" + question_id + "").append('<ul><p><a class="add_nested_fields" data-association="question_options" data-blueprint-id="questions_question_options_fields_blueprint" href="javascript:void(0)">Add option</a></p></ul>');
    }

    debugger
  })

})






