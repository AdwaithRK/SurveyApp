// $('select[name=question_type]').change(function () {
//   var selectedCar = $(this).val();
//   debugger;
//   // update DOM based on selectedCar
//   console.log(selectedCar)
// });


$(document).ready(function () {

  var option_count = 1;

  $('select[name=question_type]').change(function () {
    var selected_option = $(this).val();
    debugger;
    $('.Answer_Options').empty().show()
    $('.save-question-button').remove()

    if (selected_option == "Text") {

      debugger;
      $('.Answer_Options').append("<div><input type='text' value='' placeholder='text answer'  class='Answer_options_item' readonly /></div>")
    }
    else {
      $('.Answer_Options').append("<div id= option-" + option_count + "><input type='text' value='' placeholder='Option 1'  class='Answer_options_item'/><span color='blue' class='remove-option' data-remove-option-id=" + option_count + ">remove-option</span></div>")
      $('.Answer_Options').append("<div class='Add_Answer_option_div'><font color='blue' class='Add_Answer_options_item'>Add option</font></div>")
    }
    $('.question-box').append("<button type='button' class='btn btn-primary save-question-button'>save question</button>")
    // update DOM based on selectedCar
    // console.log(selectedCar)
  });

  $('body').on("click", ".Add_Answer_option_div", function () {
    option_count++
    $('.Add_Answer_option_div').remove()
    $('.Answer_Options').append("<div id='option-" + option_count + "'><input type='text' value='' placeholder='Option " + option_count + "'  class='Answer_options_item'/><span color='blue' class='remove-option' data-remove-option-id=" + option_count + ">remove-option</span></div>")
    $("#option-" + option_count + "").after("<div class='Add_Answer_option_div'><font color='blue' class='Add_Answer_options_item'>Add option</font></div>");
    debugger
  })

  $('body').on("click", ".remove-option", function () {
    option_attr = this.getAttribute("data-remove-option-id");
    $("#option-" + option_attr + "").remove()
    option_count--
    console.log(option_count);
  })

})

$()

