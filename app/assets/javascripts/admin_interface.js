// $('select[name=question_type]').change(function () {
//   var selectedCar = $(this).val();
//   debugger;
//   // update DOM based on selectedCar
//   console.log(selectedCar)
// });


$(document).ready(function () {

  var option_count = 0;
  var option_array = new Array()
  var selected_option
  var confirmed_question_no = 0
  var save_survey_flag = 0;

  $('select[name=question_type]').change(function () {
    selected_option = $(this).val();
    debugger;
    option_count = 0;
    option_array = [];
    $('.Answer_Options').empty().show()
    $('.save-question-button').remove()

    if (selected_option == "Text") {
      debugger;
      $('.Answer_Options').append("<div><input type='text' value='' placeholder='text answer'  class='Answer_options_item' readonly /></div>")
    }
    else {
      option_array.push(++option_count)
      $('.Answer_Options').append("<div id='option-" + option_count + "'><input type='text' value='' placeholder='Option 1'  id= 'option_" + option_count + "' class='Answer_options_item'/><span color='blue' class='remove-option' data-remove-option-id=" + option_count + ">remove-option</span></div>")
      $('.Answer_Options').append("<div class='Add_Answer_option_div'><font color='blue' class='Add_Answer_options_item'>Add option</font></div>")
    }
    $('.question-box').append("<button type='button' class='save-question-button btn btn-primary'>save question</button>")
    // update DOM based on selectedCar
    // console.log(selectedCar)
  });

  $('body').on("click", ".Add_Answer_option_div", function () {
    option_array.push(++option_count);
    debugger
    $('.Add_Answer_option_div').remove()
    $('.Answer_Options').append("<div id='option-" + option_count + "'><input type='text' value='' placeholder='Option " + option_count + "' id= 'option_" + option_count + "'  class='Answer_options_item'/><span color='blue' class='remove-option' data-remove-option-id=" + option_count + ">remove-option</span></div>")
    $("#option-" + option_count + "").after("<div class='Add_Answer_option_div'><font color='blue' class='Add_Answer_options_item'>Add option</font></div>");
  })

  $('body').on("click", ".remove-option", function () {
    debugger
    option_attr = this.getAttribute("data-remove-option-id")
    debugger
    index = option_array.indexOf(parseInt(option_attr, 10))
    debugger
    if (index > -1) {
      option_array.splice(index, 1);
      debugger
    }
    $("#option-" + option_attr + "").remove()
    option_count--
    console.log(option_count);
  })

  $('body').on("click", ".save-question-button", function () {
    console.log("trying to save")
    ++confirmed_question_no
    var question = $('#question').val()
    var question_save = $("<div id='confirmed_question_div_" + confirmed_question_no + "'>");
    $(question_save).append("<div id='confirmed_question'>•" + question + "</div>");
    var option_value
    debugger
    if (option_count > 0 && selected_option != "Text") {
      while (option_array.length > 0) {
        option_id_no = option_array.pop()
        option_value = $("#option_" + option_id_no + "").val()
        if (option_value != "") {
          $("#option_" + option_id_no + "").val("")
          $(question_save).append("  <input type=" + selected_option + ">" + option_value + "</input><br>")
        }
        debugger
      }
    }
    else {
      $(question_save).append("<textarea rows='4' cols='50'></textarea>")
    }
    debugger
    $(".confirmed-question-box").append(question_save)
    $('#question').val('');
    if (save_survey_flag == 0) {
      $('.form_div').after(
        "<button type='button' class='save-form-button btn btn-primary form-orientation'>save survey</button>"
      )
      save_survey_flag = 1;
    }

  })

})



