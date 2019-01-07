$(document).on('turbolinks:load', function () {
  $('body').on('click', '[data-editable-question]', function () {

    var $el = $(this);

    var $input = $('<input/>').val($el.text());
    debugger
    question_id = $el.attr('data-question-no')
    $el.replaceWith($input);

    var save = function () {
      var $p = $('<p style="display: inline;" data-question-no=' + question_id + ' data-editable-question />').text($input.val());
      changeEditedQuestion(index, $input.val())
      debugger
      $input.replaceWith($p);
    };

    /**
      We're defining the callback with `one`, because we know that
      the element will be gone just after that, and we don't want 
      any callbacks leftovers take memory. 
      Next time `p` turns into `input` this single callback 
      will be applied again.
    */
    $input.one('blur', save).focus();

  })


  $('body').on('click', '[data-editable-option]', function () {

    var $el = $(this);
    oldOption = $el.text()

    var $input = $('<input/>').val($el.text());
    debugger
    question_id = $el.attr('data-question-no')
    $el.replaceWith($input);

    var save = function () {
      var $p = $('<p style="display: inline;" data-question-no=' + question_id + ' data-editable-question />').text($input.val());
      newOption = $input.val()
      changeEditedOption(question_id, oldOption, newOption)
      debugger
      $input.replaceWith($p);
    };

    /**
      We're defining the callback with `one`, because we know that
      the element will be gone just after that, and we don't want 
      any callbacks leftovers take memory. 
      Next time `p` turns into `input` this single callback 
      will be applied again.
    */
    $input.one('blur', save).focus();

  })
























})