
var option_count = 0;
var option_array = new Array()
var selected_option
var confirmed_question_no = 0
var save_survey_flag = 0;

$(document).on('turbolinks:load', function () {


  $('select[name=question_type]').change(function () {
    selected_option = $(this).val();
    option_array = [];
    initial_state_question_box()
  });

  $('body').on("click", ".Add_Answer_option_div", function () {
    option_array.push(++option_count);
    Add_option()
  })

  $('body').on("click", ".remove-option", function () {
    option_attr = this.getAttribute("data-remove-option-id")
    remove_option(option_attr)
  })


  $('body').on("click", ".save-question-button", function () {
    console.log("trying to save")
    ++confirmed_question_no
    question_save = save_question()
    debugger
    option_save = save_option()
    $(question_save).append(option_save)
    index = AddQuestion()
    $(question_save[0].getElementsByTagName('p')).attr('data-question-no', index)
    question_save = AddDeleteButton(index, question_save)
    $(".confirmed-question-box").append(question_save)
    AddDeleteButton()
    $('#question').val('');
    add_save_survey_button()
    initial_state_question_box()
    var question_box = document.getElementById('question-box')
    question_box.scrollIntoView()
  })

  $('body').on("click", ".save-survey-button", function () {
    surveytitle = getSurveyTitle()
    form_description = getFormDescription()
    questions = questionArrayToJson()
    question_count = getQuestionCount()

    $.ajax({
      type: "POST",
      url: "/surveys",
      data: {
        survey: { title: surveytitle, description: form_description, questions_attributes: questions, question_count: question_count }
      }

    }

    )


  })

})
