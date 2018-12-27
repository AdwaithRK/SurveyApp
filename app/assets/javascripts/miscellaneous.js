questionArray = [];
optionsArray = [];
let question;

Array.prototype.clone = function () {
  return this.slice(0)
}

function save_option() {
  var option_value
  var option_save = $("<div id='confirmed_option_div' class='confirmed_option_div'>")
  if (option_count > 0 && selected_option != "text") {
    option_save.append("<ul>")
    while (option_array.length > 0) {
      option_id_no = option_array.shift()
      option_value = $("#option_" + option_id_no + "").val()
      optionsArray.push(option_value)
      if (option_value != "") {
        $("#option_" + option_id_no + "").val("")
        $(option_save).append("  <li>" + option_value + "</li><br>")
      }
      debugger
    }
    option_save.append("</ul>")
  }
  else {
    $(option_save).append("<textarea rows='4' cols='50'></textarea>")
  }
  return option_save;
}

function save_question() {
  question = $('#question').val()
  var question_save = $("<div id='confirmed_question_div_" + confirmed_question_no + "' class='confirmed_question_div'>");
  $(question_save).append("<div id='confirmed_question'>Q. " + question + "<span class='type-board'>type:" + selected_option + "</span></div>");
  return question_save;
}

function add_save_survey_button() {
  if (save_survey_flag == 0) {
    $('.form_div').after(
      "<button type='button' class='save-survey-button btn btn-primary form-orientation'>save survey</button>"
    )
    // $('.comfirmed-question-box').css('display', 'inline-block');
    save_survey_flag = 1;
  }
}

function initial_state_question_box() {
  option_count = 0;

  $('.Answer_Options').empty().show()
  $('.save-question-button').remove()

  if (selected_option == "text") {
    debugger;
    $('.Answer_Options').append("<div><input type='text' value='' placeholder='text answer'  class='Answer_options_item' readonly /></div>")
  }
  else {
    option_array.push(++option_count)
    $('.Answer_Options').append("<div id='option-" + option_count + "'><input type='text' value='' placeholder='Option 1'  id= 'option_" + option_count + "' class='Answer_options_item'required/><span color='blue' class='remove-option' data-remove-option-id=" + option_count + "><i class='fa fa-trash' aria-hidden='true'></i></span></div>")
    $('.Answer_Options').append("<div class='Add_Answer_option_div'><font color='blue' class='Add_Answer_options_item'>Add option</font></div>")
  }
  $('.question-box').append("<button type='button' class='save-question-button btn btn-primary'>save question</button>")
}

function Add_option() {
  $('.Add_Answer_option_div').remove()
  $('.Answer_Options').append("<div id='option-" + option_count + "'><input type='text' value='' placeholder='Option " + option_count + "' id= 'option_" + option_count + "'  class='Answer_options_item'/><span color='blue' class='remove-option' data-remove-option-id=" + option_count + "><i class='fa fa-trash' aria-hidden='true'></i></span></div>")
  $("#option-" + option_count + "").after("<div class='Add_Answer_option_div'><font color='blue' class='Add_Answer_options_item'>Add option</font></div>");
}


function remove_option(option_attr) {
  index = option_array.indexOf(parseInt(option_attr, 10))
  debugger
  if (index > -1) {
    option_array.splice(index, 1);
    debugger
  }
  $("#option-" + option_attr + "").remove()
  option_count--
}


function AddQuestion() {
  questionObj = new Question();
  questionObj.AssignQuesiton(question, selected_option)
  questionObj.AssignOption(optionsArray)
  questionObj.SaveQuestion()
  EmptyOptionsArray()
  return questionObj.GetIndex()
}

function EmptyOptionsArray() {
  optionsArray = []
}


function removeQuestion(index, confirmed_ques) {
  questionArray.splice(index, 1);
  debugger
  $("#confirmed_question_div_" + confirmed_ques + "").hide('slow', function () { $("#confirmed_question_div_" + confirmed_ques + "").remove(); })
}

function AddDeleteButton(index, question_save) {
  $(question_save).prepend("<span class='delete-question-button'  onclick='removeQuestion(" + index + "," + confirmed_question_no + ")'><i class='fa fa-trash' aria-hidden='true'></i></span>")
  return question_save
}


function questionArrayToJson() {
  let QuestionArray = questionArray.map(function (individualquestion) {
    debugger
    question_obj = new Object
    question_obj.question = individualquestion.question
    question_obj.option_count = individualquestion.optionCount
    question_obj.question_type = individualquestion.questionType
    question_obj.has_options = individualquestion.has_options
    debugger
    let new_options = individualquestion.options.map(function (e) {
      obj = new Object
      obj.option = e
      return obj
    })
    debugger
    question_obj.question_options_attributes = new_options
    return question_obj
  }
  )
  debugger
  return QuestionArray
}


function getSurveyTitle() {
  return $('#survey-title').val()
}

function getFormDescription() {
  return $('#form-description').val()
}

function getQuestionCount() {
  return questionArray.length
}

function copyLink(elem) {
  elem.select()
  document.execCommand('copy')
}
