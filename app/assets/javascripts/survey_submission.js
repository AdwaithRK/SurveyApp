$(document).on('turbolinks:load', function () {

  $(".save-response-button").click(function () {
    console.log("this is from save the answer")
    answers = new Object()
    answers.question_array = []
    question_answer = $("form").serializeArray()
    question_answer.forEach(element => {
      if (element.name == "survey") {
        answers.survey_id = element.value
      }
      else if (element.name == "username") {
        answers.user_name = element.value
      }
      else if ($.inArray(element.name, ["user[email]", "user[password]", "authenticity_token", "utf8", "_method"]) === -1) {
        answers.question_array.push({ question_id: element.name, answer_text: element.value })
      }
    });
    $.ajax({
      type: "POST",
      url: "/surveys/submit",
      data: answers
    })

  })

})