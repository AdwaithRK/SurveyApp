
$(document).on('turbolinks:load', function () {

  $('body').on("click", ".delete-survey-button", function () {
    survey_link = this.getAttribute("data-survey-link")

    console.log("heloo from delete")


    $.ajax({
      type: "DELETE",
      url: "/surveys/delete",
      data: {
        link: survey_link
      },
      success: function (data) {
        console.log(data.msg)
        if (data.msg == "destroyed") {
          $("#survey_table_" + survey_link + "").hide('slow', function () { $("#survey_table_" + survey_link + "").remove(); })
        }
      }

    }
    )

  })

})