$('body').on("click", ".delete-survey-button", function () {
    survey_link = this.getAttribute("data-survey-link")

    this.get
    $.ajax({
        type: "DELETE",
        url: "/surveys/delete",
        data: {
          survey: { title: surveytitle, description: form_description, questions_attributes: questions, question_count: question_count }
        }
  
      }
      )
})