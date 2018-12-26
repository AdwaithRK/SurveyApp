
var option_count = 0;
var option_array = new Array()
var selected_option
var confirmed_question_no = 0
var save_survey_flag = 0;

$(document).on('turbolinks:load',function () {


  $('select[name=question_type]').change(function () {
    selected_option = $(this).val();
    debugger;
    option_array = [];
    initial_state_question_box() 
  });

  $('body').on("click", ".Add_Answer_option_div", function () {
    option_array.push(++option_count);
    debugger
    Add_option()
  })

  $('body').on("click", ".remove-option", function () {
    debugger
    option_attr = this.getAttribute("data-remove-option-id")
    remove_option(option_attr)
    debugger
  })


  $('body').on("click", ".save-question-button", function () {
    console.log("trying to save")
    ++confirmed_question_no
    question_save = save_question()
    option_save = save_option()
    debugger
    $(question_save).append(option_save)
    index = AddQuestion()
    question_save = AddDeleteButton(index,question_save)
    $(".confirmed-question-box").append(question_save)
    AddDeleteButton()
    $('#question').val('');
    add_save_survey_button()
    initial_state_question_box()
    
  })

  $('body').on("click", ".save-survey-button", function () {
    console.log("saving survey")
    
  })


  
})








