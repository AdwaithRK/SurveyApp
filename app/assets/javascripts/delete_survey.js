
$(document).on('turbolinks:load', function () {

  $('body').on("click", ".delete-survey-button", function () {
    survey_link = this.getAttribute("data-survey-link")

    console.log("heloo from delete")


    $('#confirm').modal({
      backdrop: 'static',
      keyboard: false
    })
      .on('click', '#delete', function (e) {

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
              $('#confirm').modal('toggle')
            }
            page_no = parseInt($('#page_no').attr("value"))
            total_pages = parseInt($('#total_pages').attr("value"))
            record_in_current_page = parseInt($("#record_in_current_page").attr("value"))
            debugger

            if (record_in_current_page <= 5 && page_no < total_pages) {
              location.reload();
            } else if (record_in_current_page - 1 == 0) {
              $('body').find('a[rel=prev]')[0].click()
            }
          }

        }
        )

      });

  })

})
