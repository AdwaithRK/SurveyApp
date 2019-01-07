$(document).on('turbolinks:load', function () {
    $("#input_image").on('change', function () {

        var file = document.getElementById('input_image').files[0];
        console.log(file)
        console.log("hello");
        var reader = new FileReader();
        // it's onload event and you forgot (parameters)
        reader.onload = function (e) {
            var image = document.createElement("img");
            // the result image data
            image.src = e.target.result;
            image.id = "avatar_image_1"
            document.getElementById("avatar_image_1").replaceWith(image);
        }
        // you have to declare the file loading
        reader.readAsDataURL(file);
    })

}

)